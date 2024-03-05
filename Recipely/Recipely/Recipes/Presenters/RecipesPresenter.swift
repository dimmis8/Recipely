// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator)
    /// Функция получения информации о ячейке
    func getInfo(categoryNumber: Int) -> DishCategory?
    /// Получение информации о количестве категорий
    func getCategoryCount() -> Int?
    /// Переход на экран категории
    func goToCategory(_ category: RecipeCategories)
}

/// Презентер экрана м
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Private Properties

    private let informationSource = InformationSource()
    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipesViewProtocol?
    private var isFirstRequest = true

    // MARK: - Initializers

    required init(view: RecipesViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public Methods

    func goToCategory(_ category: RecipeCategories) {
        coordinator?.goToCategory(category)
    }

    func getInfo(categoryNumber: Int) -> DishCategory? {
        if isFirstRequest {
            return nil
        } else {
            return informationSource.categories[categoryNumber]
        }
    }

    func getCategoryCount() -> Int? {
        if isFirstRequest {
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
            return nil
        } else {
            return informationSource.categories.count
        }
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        view?.reloadCollectionView()
    }
}
