// RecepeCategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории рецептов
protocol RecepeCategoryPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecepeCategoryViewProtocol, coordinator: RecipesCoordinator, loggerManager: LoggerManagerProtocol)
    /// Экшн кнопки назад
    func back()
    /// Изменение состояние сортировки рецептов
    func selectedSort(_ sortType: SortTypes, newSortState: SortState)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo() -> ViewState<[Recipe]>
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> ViewState<[Recipe]>
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
    /// Добавление логов
    func sendLog(message: LogActions)
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
    private var loggerManager: LoggerManagerProtocol?
    private var selectedSortMap: [SortTypes: SortState] = [.calories: .withoutSort, .time: .withoutSort] {
        didSet {
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            state = .data(sourceOfRecepies.recipesToShow)
            view?.reloadTableView()
        }
    }

    private var sourceOfRecepies = SourceOfRecepies()
    private var isSearching = false
    private var isFirstRequest = true
    private var state: ViewState<[Recipe]>

    // MARK: - Initializers

    required init(
        view: RecepeCategoryViewProtocol,
        coordinator: RecipesCoordinator,
        loggerManager: LoggerManagerProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.loggerManager = loggerManager
        state = .noData()
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
        coordinator?.openRecipeDetails(recipe: recipe)
    }

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

    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            state = .data(sourceOfRecepies.recipesToShow)
            view?.reloadTableView()
            return
        }
        isSearching = true
        sourceOfRecepies.searchRecipes(withText: text, selectedSortMap: selectedSortMap)
        state = .loading
        Timer.scheduledTimer(
            timeInterval: 3,
            target: self,
            selector: #selector(setInfo),
            userInfo: nil,
            repeats: false
        )
        view?.reloadTableView()
    }

    func sendLog(message: LogActions) {
        loggerManager?.log(message)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
        state = .data(sourceOfRecepies.recipesToShow)
        view?.reloadTableView()
    }
}
