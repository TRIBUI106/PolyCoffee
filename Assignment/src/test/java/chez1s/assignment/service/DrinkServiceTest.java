package chez1s.assignment.service;

import chez1s.assignment.entity.Category;
import chez1s.assignment.entity.Drink;
import chez1s.assignment.repository.DrinkRepository;
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
import static org.mockito.Mockito.*;

/**
 * TC-043 to TC-054: Drink management tests
 */
@ExtendWith(MockitoExtension.class)
class DrinkServiceTest {

    @Mock
    private DrinkRepository drinkRepo;

    @InjectMocks
    private DrinkService drinkService;

    private Drink activeDrink;
    private Drink inactiveDrink;

    @BeforeEach
    void setUp() {
        Category cat = new Category();
        cat.setId(1);
        cat.setName("Coffee");

        activeDrink = new Drink();
        activeDrink.setId(1);
        activeDrink.setName("Latte");
        activeDrink.setPrice(35000);
        activeDrink.setActive(true);
        activeDrink.setCategory(cat);

        inactiveDrink = new Drink();
        inactiveDrink.setId(2);
        inactiveDrink.setName("Old Drink");
        inactiveDrink.setPrice(20000);
        inactiveDrink.setActive(false);
        inactiveDrink.setCategory(cat);
    }

    // TC-043
    @Test
    @DisplayName("TC-043: List all drinks including inactive")
    void getAllDrinks() {
        when(drinkRepo.findAll()).thenReturn(Arrays.asList(activeDrink, inactiveDrink));
        List<Drink> result = drinkService.getAllDrinks();
        assertEquals(2, result.size());
    }

    // TC-044
    @Test
    @DisplayName("TC-044: Get active drinks only")
    void getActiveDrinks() {
        when(drinkRepo.findByActive(true)).thenReturn(Arrays.asList(activeDrink));
        List<Drink> result = drinkService.getActiveDrinks();
        assertEquals(1, result.size());
        assertTrue(result.get(0).isActive());
    }

    // TC-045
    @Test
    @DisplayName("TC-045: Create drink with valid data")
    void createDrink() {
        drinkService.createDrink(activeDrink);
        verify(drinkRepo).create(activeDrink);
    }

    // TC-047
    @Test
    @DisplayName("TC-047: Update drink")
    void updateDrink() {
        drinkService.updateDrink(activeDrink);
        verify(drinkRepo).update(activeDrink);
    }

    // TC-049
    @Test
    @DisplayName("TC-049: Delete drink")
    void deleteDrink() {
        drinkService.deleteDrink(1);
        verify(drinkRepo).delete(1);
    }

    // TC-050
    @Test
    @DisplayName("TC-050: Get drink by valid ID")
    void getDrinkById_exists() {
        when(drinkRepo.findById(1)).thenReturn(activeDrink);
        Drink result = drinkService.getDrinkById(1);
        assertNotNull(result);
        assertEquals("Latte", result.getName());
    }

    // TC-051
    @Test
    @DisplayName("TC-051: Get drink by non-existent ID")
    void getDrinkById_notExists() {
        when(drinkRepo.findById(999)).thenReturn(null);
        assertNull(drinkService.getDrinkById(999));
    }

    // TC-052
    @Test
    @DisplayName("TC-052: Create drink with price=0")
    void createDrink_zeroPrice() {
        Drink freeDrink = new Drink();
        freeDrink.setName("Free Water");
        freeDrink.setPrice(0);
        drinkService.createDrink(freeDrink);
        verify(drinkRepo).create(argThat(d -> d.getPrice() == 0));
    }

    // TC-053
    @Test
    @DisplayName("TC-053: Create drink with negative price")
    void createDrink_negativePrice() {
        Drink badDrink = new Drink();
        badDrink.setName("Bad");
        badDrink.setPrice(-100);
        // Service does not validate - passes through to repo
        drinkService.createDrink(badDrink);
        verify(drinkRepo).create(argThat(d -> d.getPrice() == -100));
    }
}
