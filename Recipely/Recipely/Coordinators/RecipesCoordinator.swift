// RecipesCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу рецептов
final class RecipesCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var moduleBuilder: Builder
    var rootController: UINavigationController
    var onFinishFlow: VoidHandler?

    // MARK: - Initializers

    init(rootController: UIViewController, moduleBulder: Builder) {
        self.rootController = UINavigationController(rootViewController: rootController)
        moduleBuilder = moduleBulder
    }

    // MARK: - Public Methods

    func goToCategory(_ category: RecipeCategories) {
        let recepeCategoryView = moduleBuilder.createRecepeCategoryModule()
        recepeCategoryView.navigationItem.title = category.rawValue
        guard let recepeCategoryView = recepeCategoryView as? RecepeCategoryViewProtocol else { return }
        recepeCategoryView.presenter?.coordinator = self
        rootController.pushViewController(recepeCategoryView as? UIViewController ?? UIViewController(), animated: true)
    }

    func backToRecepies() {
        rootController.popViewController(animated: true)
    }
}
