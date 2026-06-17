package chez1s.assignment.service;

import chez1s.assignment.entity.Category;
import chez1s.assignment.repository.CategoryRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * TC-033 to TC-042: Category management tests
 */
@ExtendWith(MockitoExtension.class)
class CategoryServiceTest {

    @Mock
    private CategoryRepository categoryRepo;

    @InjectMocks
    private CategoryService categoryService;

    private Category existingCategory;

    @BeforeEach
    void setUp() {
        existingCategory = new Category();
        existingCategory.setId(1);
        existingCategory.setName("Coffee");
        existingCategory.setActive(true);
    }

    // TC-033
    @Test
    @DisplayName("TC-033: List all categories")
    void getAllCategories_returnsList() {
        when(categoryRepo.findAll()).thenReturn(Arrays.asList(existingCategory));
        List<Category> result = categoryService.getAllCategories();
        assertEquals(1, result.size());
        assertEquals("Coffee", result.get(0).getName());
    }

    // TC-034
    @Test
    @DisplayName("TC-034: Create category with valid name")
    void createCategory_validName_creates() {
        categoryService.createCategory("Tea");
        verify(categoryRepo).create(argThat(c -> c.getName().equals("Tea") && c.isActive()));
    }

    // TC-035
    @Test
    @DisplayName("TC-035: Create category with empty name")
    void createCategory_emptyName_createsOrFails() {
        // Depending on DB constraints this may throw
        categoryService.createCategory("");
        verify(categoryRepo).create(argThat(c -> c.getName().equals("")));
    }

    // TC-036
    @Test
    @DisplayName("TC-036: Update category name")
    void updateCategory_updatesName() {
        when(categoryRepo.findById(1)).thenReturn(existingCategory);
        categoryService.updateCategory(1, "New Coffee");
        assertEquals("New Coffee", existingCategory.getName());
        verify(categoryRepo).update(existingCategory);
    }

    // TC-037
    @Test
    @DisplayName("TC-037: Delete empty category (hard delete)")
    void deleteCategory_noDrinks_hardDelete() {
        when(categoryRepo.countDrinksInCategory(1)).thenReturn(0L);
        categoryService.deleteCategory(1);
        verify(categoryRepo).delete(1);
        verify(categoryRepo, never()).update(any());
    }

    // TC-038
    @Test
    @DisplayName("TC-038: Delete category with drinks (soft delete)")
    void deleteCategory_hasDrinks_softDelete() {
        when(categoryRepo.countDrinksInCategory(1)).thenReturn(5L);
        when(categoryRepo.findById(1)).thenReturn(existingCategory);
        categoryService.deleteCategory(1);
        assertFalse(existingCategory.isActive());
        verify(categoryRepo).update(existingCategory);
        verify(categoryRepo, never()).delete(anyInt());
    }

    // TC-039
    @Test
    @DisplayName("TC-039: Get category by valid ID")
    void getCategoryById_exists() {
        when(categoryRepo.findById(1)).thenReturn(existingCategory);
        Category result = categoryService.getCategoryById(1);
        assertNotNull(result);
        assertEquals("Coffee", result.getName());
    }

    // TC-040
    @Test
    @DisplayName("TC-040: Get category by non-existent ID")
    void getCategoryById_notExists_returnsNull() {
        when(categoryRepo.findById(999)).thenReturn(null);
        assertNull(categoryService.getCategoryById(999));
    }

    // TC-036 (update null category)
    @Test
    @DisplayName("TC-036b: Update non-existent category does nothing")
    void updateCategory_notExists_noOp() {
        when(categoryRepo.findById(999)).thenReturn(null);
        categoryService.updateCategory(999, "Anything");
        verify(categoryRepo, never()).update(any());
    }
}
