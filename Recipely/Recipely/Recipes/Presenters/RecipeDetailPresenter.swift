// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана деталей рецептов
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipe: Recipe,
        loggerManager: LoggerManagerProtocol
    )
    /// Сохранение рецепта в исзбранное
    func saveToFavorite()
    /// Шеринг рецепта
    func shareRecipe(message: LogActions)
    /// Экшн кнопки назад
    func back()
    /// Получение данных рецепта
    func getRecipeInfo() -> ViewState<Recipe>
    /// Добавление логов
    func sendLog(message: LogActions)
}

/// Презентер экрана деталей рецептов
final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: RecipesDetailCoordinatorProtocol?
    private weak var view: RecipeDetailViewProtocol?
    private var loggerManager: LoggerManagerProtocol?
    private var recipe: Recipe?
    private var isFirstRequest = true
    private var state: ViewState<Recipe>

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipe: Recipe,
        loggerManager: LoggerManagerProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
        self.loggerManager = loggerManager
        state = .noData()
    }

    // MARK: - Public Methods

    func getRecipeInfo() -> ViewState<Recipe> {
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

    func back() {
        coordinator?.backToRecipes()
    }

    func saveToFavorite() {
        view?.showInDevelopAlert()
    }

    func shareRecipe(message: LogActions) {
        loggerManager?.log(message)
        coordinator?.shareRecipe(text: recipe?.description ?? "")
    }

    func sendLog(message: LogActions) {
        loggerManager?.log(message)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        state = .data(recipe ?? Recipe())
        view?.reloadTableView()
    }
}
