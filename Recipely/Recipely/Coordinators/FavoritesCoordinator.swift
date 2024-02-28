// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу избранного
final class FavoritesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: VoidHandler?

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
