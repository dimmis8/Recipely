// RecipeDetailView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана деталей рецептов
protocol RecipeDetailViewProtocol: AnyObject {
    /// Презентер экрана
    var presenter: RecipeDetailPresenterProtocol? { get set }
    /// Установка цвета кнопки фаворита
    func changeFavoriteButtonColor(isFavorite: Bool)
    /// Перезагрузка данных
    func reloadTableView()
    /// Отобразить ошибку "нет данных"
    func setNoDataView()
}

/// Экран деталей рецепта
final class RecipeDetailView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let inDevelopMassage = "Functionality in development"
        static let okAlertText = "OK"
        static let reloadButtonText = "Reload"
        static let noDataText = "Failed to load data"
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
        button.setImage(.saveIcon, for: .normal)
        return button
    }()

    private let barView = UIView()

    private let recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        recipeLabel.font = .verdanaBold(ofSize: 20)
        recipeLabel.numberOfLines = 0
        recipeLabel.textAlignment = .center
        return recipeLabel
    }()

    private let backgroundLightningView: UIView = {
        let view = UIView()
        view.backgroundColor = .deviderLight
        view.layer.cornerRadius = 12
        return view
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.textColor = .lightInfoText
        label.textAlignment = .center
        return label
    }()

    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.reloadButtonText, for: .normal)
        button.titleLabel?.font = .verdana(ofSize: 14)
        button.setTitleColor(.lightInfoText, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .deviderLight
        button.setImage(.reload, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        return button
    }()

    private let errorView = UIView()

    private let errorImageView = UIImageView(image: .lightning)

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLogs()
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

    private func addLogs() {
        presenter?.sendLog()
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

    private func createErrorViewConstraints() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 8).isActive = true
        errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }

    private func createBackgroundLightningViewConstraints() {
        backgroundLightningView.translatesAutoresizingMaskIntoConstraints = false
        backgroundLightningView.topAnchor.constraint(equalTo: errorView.topAnchor).isActive = true
        backgroundLightningView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        backgroundLightningView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundLightningView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createErrorImageViewConstraints() {
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.centerYAnchor.constraint(equalTo: backgroundLightningView.centerYAnchor).isActive = true
        errorImageView.centerXAnchor.constraint(equalTo: backgroundLightningView.centerXAnchor).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func createErrorLabelConstraints() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: backgroundLightningView.bottomAnchor, constant: 17).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: errorView.widthAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func createReloadButtonConstraints() {
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.bottomAnchor.constraint(equalTo: errorView.bottomAnchor).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: errorView.centerXAnchor).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    private func configureErrorView() {
        tableView.isHidden = true
        view.addSubview(errorView)
        errorView.addSubview(backgroundLightningView)
        backgroundLightningView.addSubview(errorImageView)
        errorView.addSubview(errorLabel)
        errorView.addSubview(reloadButton)
        createErrorViewConstraints()
        createBackgroundLightningViewConstraints()
        createErrorImageViewConstraints()
        createErrorLabelConstraints()
        createReloadButtonConstraints()
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

    @objc private func reloadData() {
        presenter?.getRecipeFromNetwork()
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
            switch presenter?.getRecipeInfo() {
            case let .data(recipe):
                recipeLabel.text = recipe.label
                tableView.isScrollEnabled = true
                tableView.allowsSelection = true
                cell.getInfo(recipe: recipe)

                presenter?.loadImageDataForCell(recipe.image) { data in
                    DispatchQueue.main.async {
                        cell.setImage(imageData: data)
                    }
                }

            default:
                tableView.isScrollEnabled = false
                tableView.allowsSelection = false
                cell.getInfo(recipe: nil)
            }
            return cell
        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipesCharacteristicsDetailsCell.identifier,
                for: indexPath
            ) as? RecipesCharacteristicsDetailsCell else { return UITableViewCell() }
            switch presenter?.getRecipeInfo() {
            case let .data(recipe):
                cell.getCharacteristics(recipe: recipe)
            default:
                cell.getCharacteristics(recipe: nil)
            }
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipesDescriptionDetailsCell.identifier,
                for: indexPath
            ) as? RecipesDescriptionDetailsCell else { return UITableViewCell() }
            switch presenter?.getRecipeInfo() {
            case let .data(recipe):
                cell.setText(recipe.ingredients)
            default:
                cell.setText("")
            }
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
    func reloadTableView() {
        tableView.reloadData()
    }

    func changeFavoriteButtonColor(isFavorite: Bool) {
        let saveImage: UIImage = isFavorite ? .saved : .saveIcon
        setFavorite.setImage(saveImage, for: .normal)
    }

    func setNoDataView() {
        configureErrorView()
        errorLabel.text = Constants.noDataText
    }
}
