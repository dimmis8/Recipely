// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol RecipesViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: RecipesViewPresenterProtocol? { get set }
}

/// Экран рецептов
final class RecipesViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: RecipesViewPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .green
    }
}

// MARK: - RecipesViewController + RecipesViewProtocol

extension RecipesViewController: RecipesViewProtocol {}
