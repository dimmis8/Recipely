// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу рецептов
final class RecipesCoordinator: BaseCoodinator {
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

    func goToCategory(_ category: RecipeCategories) {
        let recepeCategoryView = moduleBuilder?.createRecepeCategoryModule(coordinator: self)
        recepeCategoryView?.navigationItem.title = category.rawValue
        rootController?.pushViewController(recepeCategoryView ?? UIViewController(), animated: true)
    }

    func backToRecepies() {
        rootController?.popViewController(animated: true)
    }

    func openRecipeDetails(recipe: Recipe) {
        let recipeDetailView = moduleBuilder?.createRecipeDetailModule(coordinator: self, recipe: recipe)
        rootController?.pushViewController(recipeDetailView ?? UIViewController(), animated: true)
    }
    
    
}
