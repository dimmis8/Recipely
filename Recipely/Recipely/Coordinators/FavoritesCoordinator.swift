// FavoritesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу избранного
final class FavoritesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?
    var rootController: UINavigationController?

    // MARK: - Private Properties

    private var moduleBuilder: Builder?

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController, moduleBuilder: Builder) {
        rootController = UINavigationController(rootViewController: view)
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - RecipesCoordinator + RecipesDetailCoordinatorProtocol

extension FavoritesCoordinator: RecipesDetailCoordinatorProtocol {
    func backToRecepies() {
        rootController?.viewControllers.first?.hidesBottomBarWhenPushed = false
        rootController?.popViewController(animated: true)
    }

    func openRecipeDetails(recipe: Recipe) {
        let recipeDetailView = moduleBuilder?.createRecipeDetailModule(coordinator: self, recipe: recipe)
        rootController?.pushViewController(recipeDetailView ?? UIViewController(), animated: true)
    }
}
