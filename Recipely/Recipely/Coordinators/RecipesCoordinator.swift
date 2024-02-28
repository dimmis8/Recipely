// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана рецептов
final class RecipesCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
