// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор приложения
final class AppCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    private var tabBarViewController: MainTabBarViewController?
    private var appBuilder: Builder

    // MARK: - Public Methods

    override func start() {
//        t​oAutorization()
        toMain()
    }

    init(appBuilder: Builder) {
        self.appBuilder = appBuilder
    }

    // MARK: - Private Methods

    private func toMain() {
        tabBarViewController = appBuilder.createTabBarModule()

        let recipesViewController = appBuilder.createRecipesModule()
        let recipesCoordinator = RecipesCoordinator(rootController: recipesViewController)
        recipesViewController.presenter.coordinator = recipesCoordinator
        add(coordinator: recipesCoordinator)

        let profileViewController = appBuilder.createProfileModule()
        let profileCoordinator = ProfileCoordinator(rootController: profileViewController, moduleBulder: appBuilder)
        profileViewController.presenter.coordinator = profileCoordinator
        add(coordinator: profileCoordinator)

        let favoritesViewController = appBuilder.createFavoritesModule()
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
            [recipesCoordinator.rootController, favoritesCoordinator.rootController, profileCoordinator.rootController],
            animated: false
        )
        setAsRoot(tabBarViewController ?? UIViewController())
    }

    private func t​oAutorization() {
        let autorizationViewController = appBuilder.createAutorizationModule()
        let autorizationCoordinator = AutorizationCoordinator(rootController: autorizationViewController)
        autorizationViewController.presenter.coordinator = autorizationCoordinator
        add(coordinator: autorizationCoordinator)

        autorizationCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: autorizationCoordinator)
            self?.toMain()
        }

        setAsRoot(autorizationCoordinator.rootController)
    }
}
