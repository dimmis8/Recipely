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
}

/// Презентер экрана деталей рецептов
final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: RecipesDetailCoordinatorProtocol?
    private weak var view: RecipeDetailViewProtocol?
    private var recipe: Recipe?

    // MARK: - Initializers

    required init(view: RecipeDetailViewProtocol, coordinator: RecipesDetailCoordinatorProtocol, recipe: Recipe) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
    }

    // MARK: - Public Methods

    func back() {
        coordinator?.backToRecipes()
    }

    func saveToFavorite() {
        view?.showInDevelopAlert()
    }

    func shareRecipe() {
        coordinator?.shareRecipe(text: recipe?.description ?? "")
    }
}
