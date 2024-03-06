// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo() -> ViewState<[Recipe]>
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> ViewState<[Recipe]>
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
    private var isFirstRequest = true
    private var state: ViewState<[Recipe]>

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        self.coordinator = coordinator
        state = .noData()
    }

    // MARK: - Private Methods

    func getRecipeInfo() -> ViewState<[Recipe]> {
        state
    }

    func getRecipeCount() -> ViewState<[Recipe]> {
        if isFirstRequest {
            state = .loading
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
        }
        return state
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = favoriteRecipesStorage.favoriteRecipes[numberOfRecipe]
        coordinator?.openRecipeDetails(recipe: recipe)
        state = .data(favoriteRecipesStorage.favoriteRecipes)
    }

    func removeRecipe(_ recipeNumber: Int) {
        favoriteRecipesStorage.favoriteRecipes.remove(at: recipeNumber)
        state = .data(favoriteRecipesStorage.favoriteRecipes)
        view?.hideCollectionView(favoriteRecipesStorage.favoriteRecipes.count == 0)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        state = .data(favoriteRecipesStorage.favoriteRecipes)
        view?.reloadTableView()
    }
}
