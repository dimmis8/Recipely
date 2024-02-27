// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана рецептов
final class RecipesCoordinator: BaseCoodinator {
    private var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }

//    func ​pushRecipes() {
//        let recepesViewController = ModuleBuilder.createRecipesModule()
//        rootController.pushViewController(recepesViewController, animated: true)
//    }
}
