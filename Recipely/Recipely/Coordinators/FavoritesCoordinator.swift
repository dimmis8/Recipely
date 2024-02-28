// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана избранного
final class FavoritesCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
