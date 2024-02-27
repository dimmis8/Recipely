// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipesViewPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: - Подписание на протокол экрана рецептов

extension RecipesViewController: RecipesViewProtocol {}
