// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана деталей рецептов
protocol RecipeDetailViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: RecipeDetailPresenterProtocol? { get set }
}

/// Экран деталей рецепта
final class RecipeDetailView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let verdanaBold = "Verdana-Bold"
    }

    enum Details {
        case photo
        case characteristics
        case description
    }

    var presenter: RecipeDetailPresenterProtocol?

    // MARK: - Visual Components

    private let tableView = UITableView()

    // MARK: - Private Properties

    private let recipeCells: [Details] = [.photo, .characteristics, .description]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setView()
        setConstraints()
        setTableView()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .green
    }

    private func setView() {
        view.addSubview(tableView)
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

extension RecipeDetailView: RecipeDetailViewProtocol {}
