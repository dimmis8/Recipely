// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipesViewPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .green
    }
}

// MARK: - Подписание на протокол экрана рецептов

extension RecipesViewController: RecipesViewProtocol {}
