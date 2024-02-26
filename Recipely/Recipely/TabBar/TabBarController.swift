// TabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер
final class TabBarController: UITabBarController {
    // MARK: - Public Properties

    weak var coordinator: TabBarCoordinator?
    var presenter: TabBarPresenter!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

/// Подписание на протокол экрана авторизации
extension TabBarController: TabBarViewProtocol {}
