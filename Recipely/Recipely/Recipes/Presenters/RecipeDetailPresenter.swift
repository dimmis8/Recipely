// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана деталей рецептов
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipe: Recipe
    )
    /// Сохранение рецепта в исзбранное
    func saveToFavorite()
    /// Шеринг рецепта
    func shareRecipe()
    /// Экшн кнопки назад
    func back()
    /// Получение данных рецепта
    func getRecipeInfo() -> ViewState<Recipe>
    /// Добавление логов
    func sendLog()
}

/// Презентер экрана деталей рецептов
final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: RecipesDetailCoordinatorProtocol?
    private weak var view: RecipeDetailViewProtocol?
    private var loggerService = LoggerService()
    private var recipe: Recipe?
    private var isFirstRequest = true
    private var state: ViewState<Recipe>

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipe: Recipe
    ) {
        self.view = view
        self.coordinator = coordinator
        self.recipe = recipe
        state = .noData()

        var favoriteRecipes = FavoriteRecipesStorage.shared.favoriteRecipes
        if favoriteRecipes == nil {
            favoriteRecipes = []
        }
        guard let favoriteRecipes = favoriteRecipes else { return }

        if favoriteRecipes.contains(where: { favoriteRecipe in
            favoriteRecipe.title == recipe.title
        }) {
            view.changeFavoriteButtonColor(isFavorite: true)
        } else {
            view.changeFavoriteButtonColor(isFavorite: false)
        }
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
        guard let recipe = recipe, let favoritesStorage = FavoriteRecipesStorage.shared.favoriteRecipes else { return }

        if favoritesStorage.contains(where: { favoriteRecipe in
            favoriteRecipe.title == recipe.title
        }) {
            FavoriteRecipesStorage.shared.favoriteRecipes?.removeAll { favoriteRecipe in
                favoriteRecipe.title == recipe.title
            }
            view?.changeFavoriteButtonColor(isFavorite: false)
        } else {
            FavoriteRecipesStorage.shared.favoriteRecipes?.append(recipe)
            view?.changeFavoriteButtonColor(isFavorite: true)
        }
    }

    func shareRecipe() {
        loggerService.log(.tapShareButton)
        coordinator?.shareRecipe(text: recipe?.description ?? "")
    }

    func sendLog() {
        loggerService.log(.openDetailsRecipe)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        state = .data(recipe ?? Recipe())
        view?.reloadTableView()
    }
}
