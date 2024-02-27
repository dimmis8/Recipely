// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    private var tabBarViewController: MainTabBarViewController?

    // MARK: - Public Methods

    override func start() {
        t​oAutorization()
        // toMain()
    }

    private func toMain() {
        tabBarViewController = ModuleBuilder.createTabBarModule()

        let recipesViewController = ModuleBuilder.createRecipesModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesViewController)
        recipesViewController.presenter.coordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        let profileViewController = ModuleBuilder.createProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileViewController)
        profileViewController.presenter.coordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        let favoritesViewController = ModuleBuilder.createFavoritesModule()
        let favoritesCoordinator = FavoritesCoordinator(rootController: favoritesViewController)
        favoritesViewController.presenter.coordinator = favoritesCoordinator
        add(coordinator: favoritesCoordinator)

        profileCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: recipesCoordinator)
            self?.remove(coordinator: favoritesCoordinator)
            self?.remove(coordinator: profileCoordinator)
            self?.tabBarViewController = nil
            self?.t​oAutorization()
        }

        tabBarViewController?.setViewControllers(
            [recipesViewController, favoritesViewController, profileViewController],
            animated: false
        )
        setAsRoot(tabBarViewController ?? UIViewController())
    }

    private func t​oAutorization() {
        let autorizationViewController = ModuleBuilder.createAutorizationModule()
        let autorizationCoordinator = AutorizationCoordinator(rootController: autorizationViewController)
        autorizationViewController.presenter.coordinator = autorizationCoordinator
        add(coordinator: autorizationCoordinator)

        autorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.toMain()
        }

        setAsRoot(autorizationViewController)
    }
}
