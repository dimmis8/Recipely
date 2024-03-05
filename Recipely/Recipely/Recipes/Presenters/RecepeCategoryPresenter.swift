// RecepeCategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории рецептов
protocol RecepeCategoryPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecepeCategoryViewProtocol, coordinator: RecipesCoordinator)
    /// Экшн кнопки назад
    func back()
    /// Изменение состояние сортировки рецептов
    func selectedSort(_ sortType: SortTypes) -> (String, Bool)
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo(forNumber number: Int) -> Recipe?
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> Int?
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
    /// Поиск рецептов по запросу
    func searchRecipes(withText text: String)
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
    private var selectedSortMap: [SortTypes: SortState] = [.calories: .withoutSort, .time: .withoutSort] {
        didSet {
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            view?.reloadTableView()
        }
    }

    private var sourceOfRecepies = SourceOfRecepies()
    private var isSearching = false

    // MARK: - Initializers

    required init(view: RecepeCategoryViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func back() {
        coordinator?.backToCategiries()
    }

    func selectedSort(_ sortType: SortTypes) -> (String, Bool) {
        let isSelected = true
        switch selectedSortMap[sortType] {
        case .withoutSort:
            selectedSortMap.updateValue(.fromLeastToMost, forKey: sortType)
            return (Constants.whiteSortDirection, isSelected)
        case .fromLeastToMost:
            selectedSortMap.updateValue(.fromMostToLeast, forKey: sortType)
            return (Constants.whiteSortDirectionRevers, isSelected)
        case .fromMostToLeast:
            selectedSortMap.updateValue(.withoutSort, forKey: sortType)
            return (Constants.blackSortDirection, !isSelected)
        default:
            return ("", !isSelected)
        }
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = sourceOfRecepies.recipesToShow[numberOfRecipe]
        coordinator?.openRecipeDetails(recipe: recipe)
    }

    func getRecipeInfo(forNumber number: Int) -> Recipe? {
        sourceOfRecepies.recipesToShow[number]
    }

    func getRecipeCount() -> Int? {
        sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
        return sourceOfRecepies.recipesToShow.count
    }

    func searchRecipes(withText text: String) {
        guard !text.isEmpty else {
            isSearching = false
            sourceOfRecepies.setNeededInformation(selectedSortMap: selectedSortMap, isSerching: isSearching)
            view?.reloadTableView()
            return
        }
        isSearching = true
        sourceOfRecepies.searchRecipes(withText: text, selectedSortMap: selectedSortMap)
        view?.reloadTableView()
    }
}
