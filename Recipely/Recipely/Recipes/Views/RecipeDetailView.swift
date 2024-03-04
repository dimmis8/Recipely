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

    enum Details {
        /// Фото блюда
        case photo
        /// Характеристики
        case characteristics
        /// Описание
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

    private lazy var recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        recipeLabel.text = presenter?.getRecipeInfo().title
        recipeLabel.font = .verdanaBold(ofSize: 20)
        recipeLabel.numberOfLines = 0
        recipeLabel.textAlignment = .center
        return recipeLabel
    }()

    private let recipeLabelView = UIView()

    private let tableView = UITableView(frame: CGRect(), style: .grouped)

    // MARK: - Public Properties

    var presenter: RecipeDetailPresenterProtocol?

    // MARK: - Private Properties

    private let recipeCells: [Details] = [.photo, .characteristics, .description]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTableView()
        setupNavigationBar()
        setConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
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

    private func setConstraints() {
        makeTableViewConstraints()
        createRecipeLabelConstraints()
    }

    private func setTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none

        tableView.register(RecipesImageDetailCell.self, forCellReuseIdentifier: RecipesImageDetailCell.identifier)
        tableView.register(
            RecipesCharacteristicsDetailsCell.self,
            forCellReuseIdentifier: RecipesCharacteristicsDetailsCell.identifier
        )
        tableView.register(
            RecipesDescriptionDetailsCell.self,
            forCellReuseIdentifier: RecipesDescriptionDetailsCell.identifier
        )
        recipeLabelView.addSubview(recipeLabel)
    }

    private func createRecipeLabelConstraints() {
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.leadingAnchor.constraint(equalTo: recipeLabelView.leadingAnchor).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo: recipeLabelView.trailingAnchor).isActive = true
        recipeLabel.centerYAnchor.constraint(equalTo: recipeLabelView.centerYAnchor).isActive = true
        recipeLabel.bottomAnchor.constraint(equalTo: recipeLabelView.bottomAnchor, constant: -10).isActive = true
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

    private func makeTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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

// MARK: - Extensions

extension RecipeDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = recipeCells[indexPath.row]
        switch cells {
        case .photo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipesImageDetailCell.identifier,
                for: indexPath
            ) as? RecipesImageDetailCell else { return UITableViewCell() }
            cell.getInfo(recipe: presenter?.getRecipeInfo() ?? Recipe())
            return cell
        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipesCharacteristicsDetailsCell.identifier,
                for: indexPath
            ) as? RecipesCharacteristicsDetailsCell else { return UITableViewCell() }
            cell.getCharacteristics(recipe: presenter?.getRecipeInfo() ?? Recipe())
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipesDescriptionDetailsCell.identifier,
                for: indexPath
            ) as? RecipesDescriptionDetailsCell else { return UITableViewCell() }
            cell.setText(presenter?.getRecipeInfo().description ?? "")
            return cell
        }
    }
}

extension RecipeDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        recipeLabelView
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RecipesDescriptionDetailsCell {
            cell.addGradient()
        }
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
