// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: FavoritesCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewProtocol)
}

/// Презентер экрана избранного
final class FavoritesPresenter: FavoritesViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: FavoritesCoordinator?
    weak var view: FavoritesViewProtocol?

    // MARK: - Initializers

    required init(view: FavoritesViewProtocol) {
        self.view = view
    }
}
