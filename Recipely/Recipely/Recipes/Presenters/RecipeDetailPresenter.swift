// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана деталей рецептов
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecipeDetailViewProtocol, coordinator: RecipesDetailCoordinatorProtocol, recipe: Recipe)
    /// Сохранение рецепта в исзбранное
    func saveToFavorite()
    /// Шеринг рецепта
    func shareRecipe()
    /// Экшн кнопки назад
    func back()
    /// Получение данных рецепта
    func getRecipeInfo() -> Recipe?
}

/// Презентер экрана деталей рецептов
final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: RecipesDetailCoordinatorProtocol?
    private weak var view: RecipeDetailViewProtocol?
    private var recipe: Recipe?
    private var isFirstRequest = true

    // MARK: - Initializers

    required init(view: RecipeDetailViewProtocol, coordinator: RecipesDetailCoordinatorProtocol, recipe: Recipe) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
    }

    // MARK: - Public Methods

    func getRecipeInfo() -> Recipe? {
        if isFirstRequest {
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
            return nil
        } else {
            return recipe
        }
    }

    func back() {
        coordinator?.backToRecipes()
    }

    func saveToFavorite() {
        view?.showInDevelopAlert()
    }

    func shareRecipe() {
        coordinator?.shareRecipe(text: recipe?.description ?? "")
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        view?.reloadTableView()
    }
}
