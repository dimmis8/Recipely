// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo() -> ViewState<[RecipeCard]>
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
    /// Удаление рецепта из фаворита
    func removeRecipe(_ recipeNumber: Int)
    /// Добавление логов
    func sendLog()
}

/// Презентер экрана избранного
final class FavoritesPresenter: FavoritesViewPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: FavoritesCoordinator?
    private weak var view: FavoritesViewProtocol?
    private var favoriteRecipesStorage = FavoriteRecipesStorage.shared
    private var loggerService = LoggerService()
    private var state: ViewState<[RecipeCard]>
    private var favoriteRecipes: [RecipeCard]

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        self.coordinator = coordinator

        guard let favoriteStorage = favoriteRecipesStorage.favoriteRecipes else {
            favoriteRecipesStorage.favoriteRecipes = []
            favoriteRecipes = []
            state = .noData()
            return
        }

        if !favoriteStorage.isEmpty {
            favoriteRecipes = favoriteStorage
            state = .data(favoriteRecipes)
        } else {
            favoriteRecipes = []
            state = .noData()
        }
    }

    // MARK: - Private Methods

    func getRecipeInfo() -> ViewState<[RecipeCard]> {
        guard let favoriteStorage = favoriteRecipesStorage.favoriteRecipes else {
            return .noData()
        }
        if !favoriteStorage.isEmpty {
            favoriteRecipes = favoriteStorage
            state = .data(favoriteRecipes)
        } else {
            favoriteRecipes = []
            state = .noData()
        }
        return state
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        coordinator?.openRecipeDetails(recipeURI: favoriteRecipes[numberOfRecipe].uri)
    }

    func sendLog() {
        loggerService.log(.openFavorites)
    }

    func removeRecipe(_ recipeNumber: Int) {
        favoriteRecipes.remove(at: recipeNumber)
        favoriteRecipesStorage.favoriteRecipes?.remove(at: recipeNumber)
        if !favoriteRecipes.isEmpty {
            state = .data(favoriteRecipes)
        } else {
            state = .noData()
        }
    }
}
