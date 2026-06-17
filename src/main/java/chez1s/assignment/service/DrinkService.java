package chez1s.assignment.service;

import chez1s.assignment.entity.Drink;
import chez1s.assignment.repository.DrinkRepository;
import java.util.List;

public class DrinkService {
    private final DrinkRepository drinkRepo = new DrinkRepository();

    public List<Drink> getAllDrinks() {
        return drinkRepo.findAll();
    }

    public List<Drink> getActiveDrinks() {
        return drinkRepo.findByActive(true);
    }

    public Drink getDrinkById(Integer id) {
        return drinkRepo.findById(id);
    }

    public void createDrink(Drink drink) {
        drinkRepo.create(drink);
    }

    public void updateDrink(Drink drink) {
        drinkRepo.update(drink);
    }

    public void deleteDrink(Integer id) {
        drinkRepo.delete(id);
    }
}
