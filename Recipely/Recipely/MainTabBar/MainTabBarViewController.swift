// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol MainTabBarViewProtocol: AnyObject {}

/// Вью главного таб бара
final class MainTabBarViewController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    // MARK: - Private Methods

    private func setupTabBar() {
        tabBar.tintColor = .selectedTitle
        tabBar.unselectedItemTintColor = .dirtyGreen
        tabBar.backgroundColor = .white
    }
}

/// MainTabBarViewController + MainTabBarViewProtocol
extension MainTabBarViewController: MainTabBarViewProtocol {}
