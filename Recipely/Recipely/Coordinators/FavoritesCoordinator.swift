// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана избранного
final class FavoritesCoordinator: BaseCoodinator {
    private var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }

//    func ​pushFavorites() {
//        let favoritesViewController = ModuleBuilder.createFavoritesModule()
//        rootController.pushViewController(favoritesViewController, animated: true)
//    }
}
