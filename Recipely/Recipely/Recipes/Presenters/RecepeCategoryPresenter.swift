// RecepeCategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории рецептов
protocol RecepeCategoryPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(
        view: RecepeCategoryViewProtocol,
        coordinator: RecipesCoordinator,
        networkService: NetworkServiceProtocol,
        category: RecipeCategories
    )
    /// Экшн кнопки назад
    func back()
    /// Изменение состояние сортировки рецептов
    func selectedSort(_ sortType: SortTypes, newSortState: SortState)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo() -> ViewState<[RecipeCard]>
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> ViewState<[RecipeCard]>
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
    /// Добавление логов
    func sendLog()
    /// Загрузить картинку для ячейки
    func loadImageDataForCell(_ imageURL: String, complitionHandler: @escaping (Data) -> ())
    /// Получить данные
    func getRecipesFromNetwork(search: String?)
}

/// Презентер экрана категории рецептов
final class RecepeCategoryPresenter: RecepeCategoryPresenterProtocol {
    // MARK: - Constants

    enum Constants {
        static let whiteSortDirectionRevers = "whiteSortDirectionRevers"
        static let whiteSortDirection = "whiteSortDirection"
        static let blackSortDirection = "sortDirection"
    }

    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecepeCategoryViewProtocol?
    private var loggerManager = LoggerService()
    private var selectedSortMap: [SortTypes: SortState] = [.calories: .withoutSort, .time: .withoutSort] {
        didSet {
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            state = .data(sourceOfRecepies.recipesToShow)
            view?.reloadTableView()
        }
    }

    private var networkService: NetworkServiceProtocol
    private var sourceOfRecepies = SourceOfRecepies()
    private var category: RecipeCategories
    private var isSearching = false
    private var state: ViewState<[RecipeCard]>

    // MARK: - Initializers

    required init(
        view: RecepeCategoryViewProtocol,
        coordinator: RecipesCoordinator,
        networkService: NetworkServiceProtocol,
        category: RecipeCategories
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        state = .loading
        self.category = category
        getRecipesFromNetwork(search: nil)
    }

    // MARK: - Public Methods

    func back() {
        coordinator?.backToCategiries()
    }

    func selectedSort(_ sortType: SortTypes, newSortState: SortState) {
        selectedSortMap.updateValue(newSortState, forKey: sortType)
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = sourceOfRecepies.recipesToShow[numberOfRecipe]
        coordinator?.openRecipeDetails(recipeURI: recipe.uri)
    }

    func getRecipeInfo() -> ViewState<[RecipeCard]> {
        state
    }

    func getRecipeCount() -> ViewState<[RecipeCard]> {
        state
    }

    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            state = .data(sourceOfRecepies.recipesToShow)
            view?.reloadTableView()
            return
        }
        isSearching = true
        getRecipesFromNetwork(search: text)
    }

    func sendLog() {
        loggerManager.log(.openCatagoryOfRecipe)
    }

    func loadImageDataForCell(_ imageURL: String, complitionHandler: @escaping (Data) -> ()) {
        networkService.getImageData(stringURL: imageURL) { result in
            if case let .success(data) = result {
                complitionHandler(data)
            }
        }
    }

    func getRecipesFromNetwork(search: String?) {
        networkService.getRecipes(
            category: category,
            search: search
        ) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(recipeCard) where recipeCard.isEmpty:
                    self.state = .noData()
                    if self.isSearching {
                        self.view?.setNothingFoundView()
                    } else {
                        self.view?.setNoDataView()
                    }
                case let .success(recipeCard):
                    if search == nil {
                        self.sourceOfRecepies.allRecipes = recipeCard
                        self.sourceOfRecepies.setNeededInformation(
                            selectedSortMap: self.selectedSortMap,
                            isSerching: false
                        )
                    } else {
                        self.sourceOfRecepies.searchRecipes(recipes: recipeCard, selectedSortMap: self.selectedSortMap)
                    }
                    self.state = .data(self.sourceOfRecepies.recipesToShow)
                    self.view?.reloadTableView()
                case let .failure(error):
                    self.state = .error(error) {}
                    self.view?.setErrorView()
                }
            }
        }
    }
}
