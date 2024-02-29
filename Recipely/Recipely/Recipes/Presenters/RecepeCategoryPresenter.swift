// RecepeCategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категории рецептов
protocol RecepeCategoryPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: RecipesCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecepeCategoryViewProtocol)
    /// Экшн кнопки назад
    func back()
    /// Изменение состояние сортировки рецептов
    func selectedSort(_ sortType: SortTypes, previousState: Bool) -> String
    /// Получение информации о рецепте для ячейки
    func getRecipeInfo(forNumber number: Int) -> Recipe
    /// Получение информации о количестве рецептов
    func getRecipeCount() -> Int
}

/// Презентер экрана категории рецептов
final class RecepeCategoryPresenter: RecepeCategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: RecipesCoordinator?
    weak var view: RecepeCategoryViewProtocol?

    // MARK: - Private Properties

    private var selectedSortMap: [SortTypes: Bool] = [.calories: false, .time: false]
    private let sourceOfRecepies = SourceOfRecepies()

    // MARK: - Initializers

    required init(view: RecepeCategoryViewProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func back() {
        coordinator?.backToRecepies()
    }

    func selectedSort(_ sortType: SortTypes, previousState: Bool) -> String {
        switch previousState {
        case true where selectedSortMap[sortType] == true:
            selectedSortMap[sortType] = false
            return "whiteSortDirectionRevers"
        case true where selectedSortMap[sortType] == false:
            selectedSortMap[sortType] = true
            return "whiteSortDirection"
        case false:
            for key in selectedSortMap.keys {
                selectedSortMap[key] = false
            }
            selectedSortMap[sortType] = true
            return "whiteSortDirection"
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
}
