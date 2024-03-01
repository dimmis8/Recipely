// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo(forNumber number: Int) -> Recipe
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> Int
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
    /// Удаление рецепта из фаворита
    func removeRecipe(_ recipeNumber: Int)
}

/// Презентер экрана избранного
final class FavoritesPresenter: FavoritesViewPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: FavoritesCoordinator?
    private weak var view: FavoritesViewProtocol?
    private var favoriteRecipesStorage = FavoriteRecipesStorage()

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Private Methods

    func getRecipeInfo(forNumber number: Int) -> Recipe {
        favoriteRecipesStorage.favoriteRecipes[number]
    }

    func getRecipeCount() -> Int {
        let recipeCount = favoriteRecipesStorage.favoriteRecipes.count
        view?.hideCollectionView(recipeCount == 0)
        return recipeCount
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = favoriteRecipesStorage.favoriteRecipes[numberOfRecipe]
        coordinator?.openRecipeDetails(recipe: recipe)
    }

    func removeRecipe(_ recipeNumber: Int) {
        favoriteRecipesStorage.favoriteRecipes.remove(at: recipeNumber)
        view?.hideCollectionView(favoriteRecipesStorage.favoriteRecipes.count == 0)
    }
}
