// TabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор таб бара
final class TabBarCoordinator: Coordinator {
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
        let tabBarController = ModuleBuilder.createTabBarModule()
        navigationController.pushViewController(tabBarController, animated: false)
    }
}
