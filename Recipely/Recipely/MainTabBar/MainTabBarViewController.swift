// MainTabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

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
