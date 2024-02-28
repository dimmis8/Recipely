// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана избранного
protocol FavoritesViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: FavoritesViewPresenterProtocol? { get set }
}

/// Экран избарнного
final class FavoritesViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: FavoritesViewPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .yellow
    }
}

// MARK: - Подписание на протокол экрана избранного

extension FavoritesViewController: FavoritesViewProtocol {}
