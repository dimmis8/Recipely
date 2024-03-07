// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol, coordinator: RecipesCoordinator, loggerManager: LoggerManagerProtocol)
    /// Функция получения информации о ячейке
    func getInfo() -> ViewState<[DishCategory]>
    /// Получение информации о количестве категорий
    func getCategoryCount() -> ViewState<[DishCategory]>
    /// Переход на экран категории
    func goToCategory(_ category: RecipeCategories)
    /// Добавление логов
    func sendLog(message: LogActions)
}

/// Презентер экрана м
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Private Properties

    private let informationSource = InformationSource()
    private weak var coordinator: RecipesCoordinator?
    private weak var view: RecipesViewProtocol?
    private var loggerManager: LoggerManagerProtocol?
    private var isFirstRequest = true
    private var state: ViewState<[DishCategory]>

    // MARK: - Initializers

    required init(
        view: RecipesViewProtocol,
        coordinator: RecipesCoordinator,
        loggerManager: LoggerManagerProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.loggerManager = loggerManager
        state = .noData()
    }

    // MARK: - Public Methods

    func goToCategory(_ category: RecipeCategories) {
        coordinator?.goToCategory(category)
    }

    func getInfo() -> ViewState<[DishCategory]> {
        state
    }

    func getCategoryCount() -> ViewState<[DishCategory]> {
        if isFirstRequest {
            // Временно приходит сразу .succes, так как не решена проблема с высотой подложки под лейблы
            isFirstRequest = false
            state = .data(informationSource.categories)
//            stateOfLoading = .loading(nil)
//            Timer.scheduledTimer(
//                timeInterval: 3,
//                target: self,
//                selector: #selector(setInfo),
//                userInfo: nil,
//                repeats: false
//            )
        }
        return state
    }

    func sendLog(message: LogActions) {
        loggerManager?.log(message)
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        state = .data(informationSource.categories)
        view?.reloadCollectionView()
    }
}
