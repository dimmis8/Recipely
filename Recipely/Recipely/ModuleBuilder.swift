// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля экрана авторизации
    func createAutorizationModule() -> AutorizationViewController
    /// Функция создания модуля экрана с таб баром
    func createTabBarModule() -> MainTabBarViewController
    /// Функция создания модуля экрана профиля
    func createProfileModule() -> ProfileViewController
    /// Функция создания модуля экрана избранного
    func createFavoritesModule() -> FavoritesViewController
    /// Функция создания модуля экрана рецептов
    func createRecipesModule() -> RecipesViewController
    /// Функция создания модуля экрана бонусов
    func createBonusesProfileModule() -> ProfileBonusesViewController
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

    func createAutorizationModule() -> AutorizationViewController {
        let view = AutorizationViewController()
        let presenter = AutorizationPresenter(view: view)
        presenter.autorizationValidation = AutorizationValidation()
        view.presenter = presenter
        return view
    }

    func createTabBarModule() -> MainTabBarViewController {
        MainTabBarViewController()
    }

    func createProfileModule() -> ProfileViewController {
        let view = ProfileViewController()
        let infoSource = InfoSource()
        let presenter = ProfilePresenter(view: view)
        presenter.infoSource = infoSource
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleProfile,
            image: .profileIcon,
            selectedImage: .selectedProfileIcon
        )
        return view
    }

    func createBonusesProfileModule() -> ProfileBonusesViewController {
        let view = ProfileBonusesViewController()
        let infoSource = InfoSource()
        let presenter = ProfileBonusesPresenter(view: view, infoSource: infoSource)
        view.presenter = presenter
        return view
    }

    func createRecipesModule() -> RecipesViewController {
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

    func createFavoritesModule() -> FavoritesViewController {
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
