// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля экрана авторизации
    func createAutorizationModule() -> UIViewController
    /// Функция создания модуля экрана с таб баром
    func createTabBarModule() -> UITabBarController
    /// Функция создания модуля экрана профиля
    func createProfileModule() -> UIViewController
    /// Функция создания модуля экрана избранного
    func createFavoritesModule() -> UIViewController
    /// Функция создания модуля экрана рецептов
    func createRecipesModule() -> UIViewController
    /// Функция создания модуля экрана бонусов
    func createBonusesProfileModule() -> UIViewController
    /// Функция создания модуля блюд категории
    func createRecepeCategoryModule() -> UIViewController
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

    func createAutorizationModule() -> UIViewController {
        let view = AutorizationViewController()
        let presenter = AutorizationPresenter(view: view)
        presenter.autorizationValidation = AutorizationValidation()
        view.presenter = presenter
        return view
    }

    func createTabBarModule() -> UITabBarController {
        MainTabBarViewController()
    }

    func createProfileModule() -> UIViewController {
        let view = ProfileViewController()
        let infoSource = InfoSource()
        let presenter = ProfilePresenter(view: view, infoSource: infoSource)
        view.presenter = presenter
        view.tabBarItem = UITabBarItem(
            title: Constants.titleProfile,
            image: .profileIcon,
            selectedImage: .selectedProfileIcon
        )
        return view
    }

    func createBonusesProfileModule() -> UIViewController {
        let view = ProfileBonusesViewController()
        let infoSource = InfoSource()
        let presenter = ProfileBonusesPresenter(view: view, infoSource: infoSource)
        view.presenter = presenter
        return view
    }

    func createRecipesModule() -> UIViewController {
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

    func createRecepeCategoryModule() -> UIViewController {
        let view = RecepeCategoryView()
        let presenter = RecepeCategoryPresenter(view: view)
        view.presenter = presenter
        return view
    }

    func createFavoritesModule() -> UIViewController {
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
