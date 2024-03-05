// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo() -> ViewData<[Recipe]>
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> ViewData<[Recipe]>
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
    private var stateOfLoading: ViewData<[Recipe]>

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol, coordinator: FavoritesCoordinator) {
        self.view = view
        self.coordinator = coordinator
        stateOfLoading = .initial
    }

    // MARK: - Private Methods

    func getRecipeInfo() -> ViewData<[Recipe]> {
        stateOfLoading
    }

    func getRecipeCount() -> ViewData<[Recipe]> {
        if isFirstRequest {
            stateOfLoading = .loading(nil)
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
        }
        return stateOfLoading
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = favoriteRecipesStorage.favoriteRecipes[numberOfRecipe]
        coordinator?.openRecipeDetails(recipe: recipe)
        stateOfLoading = .succes(favoriteRecipesStorage.favoriteRecipes)
    }

    func removeRecipe(_ recipeNumber: Int) {
        favoriteRecipesStorage.favoriteRecipes.remove(at: recipeNumber)
        stateOfLoading = .succes(favoriteRecipesStorage.favoriteRecipes)
        view?.hideCollectionView(favoriteRecipesStorage.favoriteRecipes.count == 0)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        stateOfLoading = .succes(favoriteRecipesStorage.favoriteRecipes)
        view?.reloadTableView()
    }
}
