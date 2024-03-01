// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу избранного
final class FavoritesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?
    var rootController: UINavigationController?

    // MARK: - Private Properties

    private var moduleBuilder: Builder?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController, moduleBuilder: Builder) {
        rootController = UINavigationController(rootViewController: view)
        self.moduleBuilder = moduleBuilder
    }
}
