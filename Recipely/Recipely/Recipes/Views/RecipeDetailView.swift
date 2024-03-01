// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана деталей рецептов
protocol RecipeDetailViewProtocol: AnyObject {
    /// Презентер экрана
    var presenter: RecipeDetailPresenterProtocol? { get set }
    /// Показать алерт о том, что функционал в разработке
    func showInDevelopAlert()
}

/// Экран деталей рецепта
final class RecipeDetailView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let inDevelopMassage = "Functionality in development"
        static let okAlertText = "OK"
    }

    // MARK: - Visual Components

    private let backBarButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrow, for: .normal)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.sendIcon, for: .normal)
        return button
    }()

    private let setFavorite: UIButton = {
        let button = UIButton()
        button.setImage(.savedIcon, for: .normal)
        return button
    }()

    private let barView = UIView()

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        backBarButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        barView.addSubview(shareButton)
        barView.addSubview(setFavorite)
        createShareButtonConstraints()
        createSetFavoriteConstraints()
        createBarViewConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barView)
        setFavorite.addTarget(self, action: #selector(saveHandler), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareRecipe), for: .touchUpInside)
    }

    private func createShareButtonConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        shareButton.trailingAnchor.constraint(equalTo: setFavorite.leadingAnchor, constant: -4).isActive = true
        shareButton.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
    }

    private func createSetFavoriteConstraints() {
        setFavorite.translatesAutoresizingMaskIntoConstraints = false
        setFavorite.heightAnchor.constraint(equalToConstant: 24).isActive = true
        setFavorite.widthAnchor.constraint(equalToConstant: 24).isActive = true
        setFavorite.trailingAnchor.constraint(equalTo: barView.trailingAnchor).isActive = true
        setFavorite.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
    }

    private func createBarViewConstraints() {
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    @objc private func back() {
        presenter?.back()
    }

    @objc private func saveHandler() {
        presenter?.saveToFavorite()
    }

    @objc private func shareRecipe() {
        presenter?.shareRecipe()
    }
}

// MARK: - RecipeDetailView + RecipeDetailViewProtocol

extension RecipeDetailView: RecipeDetailViewProtocol {
    func showInDevelopAlert() {
        let alertController = UIAlertController(title: Constants.inDevelopMassage, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.okAlertText, style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
