// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Авторизационный координатор приложения
final class AutorizationCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?

    // MARK: - Public Properties

    var childrenCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    func start() {
        let autorizationViewController = ModuleBuilder.createAutorizationModule()
        navigationController.pushViewController(autorizationViewController, animated: false)
    }
}
