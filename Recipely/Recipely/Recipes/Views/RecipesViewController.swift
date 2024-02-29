// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol RecipesViewProtocol: AnyObject {
    /// Презентер экрана
    var presenter: RecipesViewPresenterProtocol? { get set }
}

/// Экран рецептов
final class RecipesViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.setTitle("in category", for: .normal)
        return button
    }()

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
        view.addSubview(button)
        button.addTarget(self, action: #selector(goToCategory), for: .touchUpInside)
    }

    @objc private func goToCategory() {
        presenter?.goToCategory(.fish)
    }
}

// MARK: - RecipesViewController + RecipesViewProtocol

extension RecipesViewController: RecipesViewProtocol {}
