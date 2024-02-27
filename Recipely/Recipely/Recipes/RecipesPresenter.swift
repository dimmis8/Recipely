// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана рецептов
protocol RecipesViewProtocol: AnyObject {}

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    var coordinator: RecipesCoordinator? { get set }
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
