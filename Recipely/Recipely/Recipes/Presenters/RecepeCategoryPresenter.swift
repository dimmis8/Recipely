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
    func selectedSort(_ sortType: SortTypes, previousState: Bool) -> String
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo(forNumber number: Int) -> Recipe
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> Int
    /// Переход на экран деталей
    func goToRecipeDetail(numberOfRecipe: Int)
}

/// Презентер экрана категории рецептов
final class RecepeCategoryPresenter: RecepeCategoryPresenterProtocol {
    // MARK: - Constants

    enum Constants {
        static let whiteSortDirectionRevers = "whiteSortDirectionRevers"
        static let whiteSortDirection = "whiteSortDirection"
    }

    // MARK: - Private Properties

    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecepeCategoryViewProtocol?
    private var selectedSortMap: [SortTypes: Bool] = [.calories: false, .time: false]
    private let sourceOfRecepies = SourceOfRecepies()

    // MARK: - Initializers

    required init(view: RecepeCategoryViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func back() {
        coordinator?.backToCategiries()
    }

    func selectedSort(_ sortType: SortTypes, previousState: Bool) -> String {
        switch previousState {
        case true where selectedSortMap[sortType] == true:
            selectedSortMap[sortType] = false
            return Constants.whiteSortDirectionRevers
        case true where selectedSortMap[sortType] == false:
            selectedSortMap[sortType] = true
            return Constants.whiteSortDirection
        case false:
            for key in selectedSortMap.keys {
                selectedSortMap[key] = false
            }
            selectedSortMap[sortType] = true
            return Constants.whiteSortDirection
        default:
            return ""
        }
    }

    func getRecipeInfo(forNumber number: Int) -> Recipe {
        sourceOfRecepies.fishRecepies[number]
    }

    func getRecipeCount() -> Int {
        sourceOfRecepies.fishRecepies.count
    }

    func goToRecipeDetail(numberOfRecipe: Int) {
        let recipe = sourceOfRecepies.fishRecepies[numberOfRecipe]
        coordinator?.openRecipeDetails(recipe: recipe)
    }
}
