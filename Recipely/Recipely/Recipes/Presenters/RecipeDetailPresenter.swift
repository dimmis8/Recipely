// RecipeDetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана деталей рецептов
protocol RecipeDetailPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipeURI: String,
        networkService: NetworkServiceProtocol
    )
    /// Сохранение рецепта в исзбранное
    func saveToFavorite()
    /// Шеринг рецепта
    func shareRecipe()
    /// Экшн кнопки назад
    func back()
    /// Получение данных рецепта
    func getRecipeInfo() -> ViewState<RecipeDetails>
    /// Добавление логов
    func sendLog()
    /// Получить данные
    func getRecipeFromNetwork()
    /// Загрузить картинку для ячейки
    func loadImageDataForCell(_ imageURL: String, complitionHandler: @escaping (Data) -> ())
}

/// Презентер экрана деталей рецептов
final class RecipeDetailPresenter: RecipeDetailPresenterProtocol {
    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private weak var coordinator: RecipesDetailCoordinatorProtocol?
    private weak var view: RecipeDetailViewProtocol?
    private var loggerService = LoggerService()
    private var recipeURI: String
    private var isFirstRequest = true
    private var state: ViewState<RecipeDetails>
    private var imageData: Data?

    // MARK: - Initializers

    required init(
        view: RecipeDetailViewProtocol,
        coordinator: RecipesDetailCoordinatorProtocol,
        recipeURI: String,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.recipeURI = recipeURI
        self.networkService = networkService
        state = .loading
        getRecipeFromNetwork()
    }

    // MARK: - Public Methods

    func getRecipeInfo() -> ViewState<RecipeDetails> {
        state
    }

    func back() {
        coordinator?.backToRecipes()
    }

    func saveToFavorite() {
        guard case let .data(recipe) = state,
              let favoritesStorage = FavoriteRecipesStorage.shared.favoriteRecipes
        else { return
        }

        if favoritesStorage.contains(where: { favoriteRecipe in
            favoriteRecipe.label == recipe.label
        }) {
            FavoriteRecipesStorage.shared.favoriteRecipes?.removeAll { favoriteRecipe in
                favoriteRecipe.label == recipe.label
            }
            view?.changeFavoriteButtonColor(isFavorite: false)
        } else {
            FavoriteRecipesStorage.shared.favoriteRecipes?.append(RecipeCard(
                label: recipe.label,
                image: recipe.label,
                totalTime: recipe.totalTime,
                calories: recipe.calories,
                uri: recipe.uri,
                imageData: imageData
            ))
            view?.changeFavoriteButtonColor(isFavorite: true)
        }
    }

    func shareRecipe() {
        guard case let .data(data) = state else { return }
        loggerService.log(.tapShareButton)
        coordinator?.shareRecipe(text: data.ingredients)
    }

    func sendLog() {
        loggerService.log(.openDetailsRecipe)
    }

    func loadImageDataForCell(_ imageURL: String, complitionHandler: @escaping (Data) -> ()) {
        networkService.getImageData(stringURL: imageURL) { [weak self] result in
            if case let .success(data) = result {
                self?.imageData = data
                complitionHandler(data)
            }
        }
    }

    func getRecipeFromNetwork() {
        networkService.getDetail(uri: recipeURI) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(recipeDetails):
                    self.state = .data(recipeDetails)

                    var favoriteRecipes = FavoriteRecipesStorage.shared.favoriteRecipes

                    if favoriteRecipes == nil {
                        favoriteRecipes = []
                    }
                    guard let favoriteRecipes = favoriteRecipes else { return }

                    if favoriteRecipes.contains(where: { favoriteRecipe in
                        favoriteRecipe.label == recipeDetails.label
                    }) {
                        self.view?.changeFavoriteButtonColor(isFavorite: true)
                    } else {
                        self.view?.changeFavoriteButtonColor(isFavorite: false)
                    }

                case let .failure(error):
                    self.state = .error(error) {}
                    self.view?.setNoDataView()
                }
                self.view?.reloadTableView()
            }
        }
    }
}
