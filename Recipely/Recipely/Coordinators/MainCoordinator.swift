// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class MainCoordinator: Coordinator {
    // MARK: - Public Properties

    var childrenCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods

    func start() {
        autorizationSubscription()
        // tabBarSubscription()
    }

    func autorizationSubscription() {
        let child = AutorizationCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childrenCoordinators.append(child)
        child.start()
    }

    func tabBarSubscription() {
        let child = TabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childrenCoordinators.append(child)
        child.start()
    }
}
