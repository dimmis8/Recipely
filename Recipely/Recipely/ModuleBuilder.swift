// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля экрана авторизации
    static func createAutorizationModule() -> AutorizationViewController
    /// Функция создания модуля экрана с таб баром
    static func createTabBarModule() -> MainTabBarViewController
    /// Функция создания модуля экрана профиля
    static func createProfileModule() -> ProfileViewController
    /// Функция создания модуля экрана избранного
    static func createFavoritesModule() -> FavoritesViewController
}

/// Билдер модулей
final class ModuleBuilder: Builder {
    // MARK: - Constants

    enum Constants {
        static let titleRecipes = "Recipes"
        static let titleFavorites = "Favorites"
        static let titleProfile = "Profile"
    }

    // MARK: - Public Properties

    static func createAutorizationModule() -> AutorizationViewController {
        let view = AutorizationViewController()
        let presenter = AutorizationPresenter(view: view)
        presenter.autorizationValidation = AutorizationValidation()
        view.presenter = presenter
        return view
    }

    static func createTabBarModule() -> MainTabBarViewController {
        MainTabBarViewController()
    }

    static func createProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter(view: view)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleProfile,
            image: .profileIcon,
            selectedImage: .selectedProfileIcon
        )
        return view
    }

    static func createRecipesModule() -> RecipesViewController {
        let view = RecipesViewController()
        let presenter = RecipesPresenter(view: view)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleRecipes,
            image: .recipesIcon,
            selectedImage: .selectedRecipesIcon
        )
        return view
    }

    static func createFavoritesModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesPresenter(view: view)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleFavorites,
            image: .favoritesIcon,
            selectedImage: .selectedFavoriteIcon
        )
        return view
    }
}
