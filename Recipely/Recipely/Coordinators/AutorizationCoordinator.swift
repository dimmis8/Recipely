// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Авторизационный флоу приложения
final class AutorizationCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: VoidHandler?

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    // MARK: - Public Methods

    func logIn() {
        onFinishFlow?()
    }
}
