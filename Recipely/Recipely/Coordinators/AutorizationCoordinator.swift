// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Авторизационный координатор приложения
final class AutorizationCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    // MARK: - Initializers

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    // MARK: - Public Methods

    func logIn() {
        onFinishFlow?()
    }
}
