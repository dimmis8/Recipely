// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator)
    /// Функция получения информации о ячейке
    func getInfo(categoryNumber: Int) -> DishCategory
    /// Получение информации о количестве категорий
    func getCategoryCount() -> Int
    /// Переход на экран категории
    func goToCategory(_ category: RecipeCategories)
}

/// Презентер экрана м
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Private Properties

    private let informationSource = InformationSource()
    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipesViewProtocol?

    // MARK: - Initializers

    required init(view: RecipesViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func goToCategory(_ category: RecipeCategories) {
        coordinator?.goToCategory(category)
    }

    func getInfo(categoryNumber: Int) -> DishCategory {
        informationSource.categories[categoryNumber]
    }

    func getCategoryCount() -> Int {
        informationSource.categories.count
    }
}
