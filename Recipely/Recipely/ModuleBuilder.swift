// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля экрана авторизации
    func createAutorizationModule(coordinator: AutorizationCoordinator) -> UIViewController
    /// Функция создания модуля экрана с таб баром
    func createTabBarModule() -> UITabBarController
    /// Функция создания модуля экрана профиля
    func createProfileModule(coordinator: ProfileCoordinator) -> UIViewController
    /// Функция создания модуля экрана избранного
    func createFavoritesModule(coordinator: FavoritesCoordinator) -> UIViewController
    /// Функция создания модуля экрана рецептов
    func createRecipesModule(coordinator: RecipesCoordinator) -> UIViewController
    /// Функция создания модуля экрана бонусов
    func createBonusesProfileModule(coordinator: ProfileCoordinator) -> UIViewController
    /// Функция создания модуля блюд категории
    func createRecepeCategoryModule(coordinator: RecipesCoordinator) -> UIViewController
}

/// Билдер модулей
final class ModuleBuilder: Builder {
    // MARK: - Constants

    enum Constants {
        static let titleRecipes = "Recipes"
        static let titleFavorites = "Favorites"
        static let titleProfile = "Profile"
    }

    // MARK: - Public Methods

    func createAutorizationModule(coordinator: AutorizationCoordinator) -> UIViewController {
        let view = AutorizationViewController()
        let autorizationValidation = AutorizationValidation()
        let presenter = AutorizationPresenter(
            view: view,
            autorizationValidation: autorizationValidation,
            coordinator: coordinator
        )
        view.presenter = presenter
        return view
    }

    func createTabBarModule() -> UITabBarController {
        MainTabBarViewController()
    }

    func createProfileModule(coordinator: ProfileCoordinator) -> UIViewController {
        let view = ProfileViewController()
        let infoSource = InfoSource()
        let presenter = ProfilePresenter(view: view, infoSource: infoSource, coordinator: coordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleProfile,
            image: .profileIcon,
            selectedImage: .selectedProfileIcon
        )
        return view
    }

    func createBonusesProfileModule(coordinator: ProfileCoordinator) -> UIViewController {
        let view = ProfileBonusesViewController()
        let infoSource = InfoSource()
        let presenter = ProfileBonusesPresenter(view: view, infoSource: infoSource, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func createRecipesModule(coordinator: RecipesCoordinator) -> UIViewController {
        let view = RecipesViewController()
        let presenter = RecipesPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleRecipes,
            image: .recipesIcon,
            selectedImage: .selectedRecipesIcon
        )
        return view
    }

    func createRecepeCategoryModule(coordinator: RecipesCoordinator) -> UIViewController {
        let view = RecepeCategoryView()
        let presenter = RecepeCategoryPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        return view
    }

    func createFavoritesModule(coordinator: FavoritesCoordinator) -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter(view: view, coordinator: coordinator)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleFavorites,
            image: .favoritesIcon,
            selectedImage: .selectedFavoriteIcon
        )
        return view
    }
}
