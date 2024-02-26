// ModuleBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера
protocol Builder {
    /// Функция создания модуля экрана авторизации
    static func createAutorizationModule() -> AutorizationViewController
    /// Функция создания модуля экрана с таб баром
    static func createTabBarModule() -> TabBarController
}

/// Билдер модулей
final class ModuleBuilder: Builder {
    // MARK: - Public Properties

    static func createAutorizationModule() -> AutorizationViewController {
        let view = AutorizationViewController()
        let presenter = AutorizationPresenter(view: view)
        view.presenter = presenter
        return view
    }

    static func createTabBarModule() -> TabBarController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
