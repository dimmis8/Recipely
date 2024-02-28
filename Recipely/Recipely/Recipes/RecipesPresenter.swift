// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: RecipesCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipesViewProtocol)
}

/// Презентер экрана м
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: RecipesCoordinator?
    weak var view: RecipesViewProtocol?

    // MARK: - Initializers

    required init(view: RecipesViewProtocol) {
        self.view = view
    }
}
