// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator)
    /// Функция получения информации о ячейке
    func getInfo() -> ViewData<[DishCategory]>
    /// Получение информации о количестве категорий
    func getCategoryCount() -> ViewData<[DishCategory]>
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
    private var stateOfLoading: ViewData<[DishCategory]>

    // MARK: - Initializers

    required init(view: RecipesViewProtocol, coordinator: RecipesCoordinator) {
        self.view = view
        self.coordinator = coordinator
        stateOfLoading = .initial
    }

    // MARK: - Public Methods

    func goToCategory(_ category: RecipeCategories) {
        coordinator?.goToCategory(category)
    }

    func getInfo() -> ViewData<[DishCategory]> {
        stateOfLoading
    }

    func getCategoryCount() -> ViewData<[DishCategory]> {
        if isFirstRequest {
            stateOfLoading = .loading(nil)
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
        }
        return stateOfLoading
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        stateOfLoading = .succes(informationSource.categories)
        view?.reloadCollectionView()
    }
}
