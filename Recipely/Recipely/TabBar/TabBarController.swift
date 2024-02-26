// TabBarController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Таб бар контроллер
final class TabBarController: UITabBarController {
    weak var coordinator: TabBarCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
