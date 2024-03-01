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
        static let verdanaBold = "Verdana-Bold"
        static let inDevelopMassage = "Functionality in development"
        static let okAlertText = "OK"
    }

    enum Details {
        case photo
        case characteristics
        case description
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

    // MARK: - Visual Components

    private let tableView = UITableView()

    // MARK: - Private Properties

    private let recipeCells: [Details] = [.photo, .characteristics, .description]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setTableView()
        setupNavigationBar()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
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

    private func setConstraints() {
        makeTableViewConstraints()
    }

    private func setTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "DetailsTableViewHeader")

        tableView.register(RecipesImageDetailCell.self, forCellReuseIdentifier: RecipesImageDetailCell.identifier)
        tableView.register(
            RecipesCharacteristicsDetailsCell.self,
            forCellReuseIdentifier: RecipesCharacteristicsDetailsCell.identifier
        )
        tableView.register(
            RecipesDescriptionDetailsCell.self,
            forCellReuseIdentifier: RecipesDescriptionDetailsCell.identifier
        )
    }

    private func makeTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = recipeCells[indexPath.row]
        switch cells {
        case .photo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecipesImageDetailCell",
                for: indexPath
            ) as? RecipesImageDetailCell else { return UITableViewCell() }
            return cell
        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecipesCharacteristicsDetailsCell",
                for: indexPath
            ) as? RecipesCharacteristicsDetailsCell else { return UITableViewCell() }
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RecipesDescriptionDetailsCell",
                for: indexPath
            ) as? RecipesDescriptionDetailsCell else { return UITableViewCell() }
            return cell
        }
    }
}

extension RecipeDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView
//            .dequeueReusableHeaderFooterView(withIdentifier: "DetailsTableViewHeader") as? DetailsTableViewHeader
//        else { return UIView() }
//
//        header.textLabel?.text = presenter?.getRecipeInfo().title
//
//        return header
        let recipeLabel = UILabel()
        recipeLabel.text = presenter?.getRecipeInfo().title
        recipeLabel.font = .init(name: Constants.verdanaBold, size: 20)
        recipeLabel.textAlignment = .center
        return recipeLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
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
