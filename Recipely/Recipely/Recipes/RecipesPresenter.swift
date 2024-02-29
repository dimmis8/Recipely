// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: RecipesCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol)
    func getInfo(categoryNumber: Int) -> DishCategory
    func getCategoryCount() -> Int
    func goToCategory(_ category: RecipeCategories)
}

/// Презентер экрана м
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Public Properties

    private let informationSource = InformationSource()
    weak var coordinator: RecipesCoordinator?
    weak var view: RecipesViewProtocol?

    // MARK: - Initializers

    required init(view: RecipesViewProtocol) {
        self.view = view
    }

    func getInfo(categoryNumber: Int) -> DishCategory {
        informationSource.categories[categoryNumber]
    }

    func getCategoryCount() -> Int {
        informationSource.categories.count
    }

    func goToCategory(_ category: RecipeCategories) {}
}
