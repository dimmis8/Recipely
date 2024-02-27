// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана избранного
protocol FavoritesViewProtocol: AnyObject {}

/// Протокол презентера экрана избранного
protocol FavoritesViewPresenterProtocol: AnyObject {
    var coordinator: FavoritesCoordinator? { get set }
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
