package chez1s.assignment.service;

import chez1s.assignment.entity.Category;
import chez1s.assignment.repository.CategoryRepository;
import java.util.List;

public class CategoryService {
    private final CategoryRepository categoryRepo = new CategoryRepository();

    public List<Category> getAllCategories() {
        return categoryRepo.findAll();
    }

    public Category getCategoryById(Integer id) {
        return categoryRepo.findById(id);
    }

    public void createCategory(String name) {
        Category category = new Category();
        category.setName(name);
        category.setActive(true);
        categoryRepo.create(category);
    }

    public void updateCategory(Integer id, String name) {
        Category category = categoryRepo.findById(id);
        if (category != null) {
            category.setName(name);
            categoryRepo.update(category);
        }
    }

    public void deleteCategory(Integer id) {
        long drinkCount = categoryRepo.countDrinksInCategory(id);
        if (drinkCount > 0) {
            // Soft delete if drinks exist
            Category category = categoryRepo.findById(id);
            if (category != null) {
                category.setActive(false);
                categoryRepo.update(category);
            }
        } else {
            // Hard delete if no drinks
            categoryRepo.delete(id);
        }
    }
}
