// RecepeCategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol RecepeCategoryViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: RecepeCategoryPresenterProtocol? { get set }
}

/// Экран рецептов
final class RecepeCategoryView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let verdanaBold = "Verdana-Bold"
        static let verdana = "Verdana"
        static let seatchBarText = "Search recipes"
        static let recipeCellIdentifier = "RecipeCell"
        static let buttonSortHigh: CGFloat = 36
    }

    // MARK: - Visual Components

    private let backBarButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrow, for: .normal)
        return button
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: Constants.verdanaBold, size: 28)
        label.textColor = .black
        return label
    }()

    private let barView = UIView()

    private let recipesSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.seatchBarText
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.searchTextField.backgroundColor = .deviderLight
        return searchBar
    }()

    private let sortPickerView = SortPickerView()
    private let tableView = UITableView()

    // MARK: - Public Properties

    var presenter: RecepeCategoryPresenterProtocol?

    // MARK: - Private Properties

    private var sortButtons: [UIButton] = []
    private let sortTypes: [SortTypes] = [.calories, .time]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        configureTableView()
        createConstraints()
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        categoryLabel.text = navigationItem.title
        navigationItem.title = nil
        barView.addSubview(backBarButton)
        barView.addSubview(categoryLabel)
        createBackBarButtonConstraints()
        createCategoryLabelConstraints()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barView)
        backBarButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }

    private func configureTableView() {
        tableView.register(RecipeCell.self, forCellReuseIdentifier: Constants.recipeCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(recipesSearchBar)
        sortPickerView.dataSource = self
        view.addSubview(sortPickerView)
        view.addSubview(tableView)
    }

    private func createConstraints() {
        createSearchBarConstraints()
        createBarViewConstraints()
        createSortPickerViewConstraints()
        createTableViewConstraints()
    }

    private func createBackBarButtonConstraints() {
        backBarButton.translatesAutoresizingMaskIntoConstraints = false
        backBarButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBarButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backBarButton.leadingAnchor.constraint(equalTo: barView.leadingAnchor).isActive = true
        backBarButton.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
    }

    private func createCategoryLabelConstraints() {
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: backBarButton.trailingAnchor, constant: 20).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: barView.topAnchor).isActive = true
    }

    private func createBarViewConstraints() {
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createSearchBarConstraints() {
        recipesSearchBar.translatesAutoresizingMaskIntoConstraints = false
        recipesSearchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            .isActive = true
        recipesSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        recipesSearchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            .isActive = true
        recipesSearchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func createSortPickerViewConstraints() {
        sortPickerView.translatesAutoresizingMaskIntoConstraints = false
        sortPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            .isActive = true
        if sortTypes.count * 100 > Int(view.frame.width) {
            sortPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        } else {
            sortPickerView.widthAnchor.constraint(equalToConstant: CGFloat(sortTypes.count * 100))
                .isActive = true
        }
        sortPickerView.topAnchor.constraint(equalTo: recipesSearchBar.bottomAnchor, constant: 20).isActive = true
        sortPickerView.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }

    private func createTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: sortPickerView.bottomAnchor, constant: 15).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc private func back() {
        presenter?.back()
    }
}

// MARK: - RecepeCategoryView + RecepeCategoryViewProtocol

extension RecepeCategoryView: RecepeCategoryViewProtocol {}

// MARK: - RecepeCategoryView + SortPickerViewDataSource

extension RecepeCategoryView: SortPickerViewDataSource {
    func sortPickerImage(indexPath: IndexPath, beforeSelected: Bool) -> String {
        presenter?.selectedSort(sortTypes[indexPath.row], previousState: beforeSelected) ?? ""
    }

    func sortPickerCount(_ sortPicker: SortPickerView) -> Int {
        sortTypes.count
    }

    func sortPickerTitle(_ sortPicker: SortPickerView, indexPath: IndexPath) -> String {
        sortTypes[indexPath.item].rawValue
    }
}

// MARK: - RecepeCategoryView + UITableViewDataSource

extension RecepeCategoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getRecipeCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.recipeCellIdentifier,
            for: indexPath
        ) as? RecipeCell else { return UITableViewCell() }
        cell.loadInfo(recipe: presenter?.getRecipeInfo(forNumber: indexPath.row) ?? Recipe())
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToRecipeDetail(numberOfRecipe: indexPath.row)
    }
}

// MARK: - RecepeCategoryView + UITableViewDelegate

extension RecepeCategoryView: UITableViewDelegate {}
