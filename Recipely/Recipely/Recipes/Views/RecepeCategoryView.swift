// RecepeCategoryView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана рецептов
protocol RecepeCategoryViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: RecepeCategoryPresenterProtocol? { get set }
    /// Обновить таблицу
    func reloadTableView()
    /// Отобразить ошибку "нет данных"
    func setNoDataView()
    /// Отобразить ошибку
    func setErrorView()
}

/// Экран рецептов
final class RecepeCategoryView: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let seatchBarText = "Search recipes"
        static let buttonSortHigh: CGFloat = 36
        static let reloadButtonText = "Reload"
        static let noDataText = "Failed to load data"
        static let textError = "Error"
    }

    // MARK: - Visual Components

    private let backBarButton: UIButton = {
        let button = UIButton()
        button.setImage(.arrow, for: .normal)
        return button
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .verdanaBold(ofSize: 28)
        label.textColor = .black
        return label
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addLogs()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deselectedSelectedRow()
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
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
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
        recipesSearchBar.delegate = self
        view.addSubview(sortPickerView)
        view.addSubview(tableView)
    }

    private func createConstraints() {
        createSearchBarConstraints()
        createBarViewConstraints()
        createSortPickerViewConstraints()
        createTableViewConstraints()
    }

    private func deselectedSelectedRow() {
        if let selectedIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: selectedIndex)?.isSelected = false
        }
    }

    private func addLogs() {
        presenter?.sendLog()
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

    @objc private func reloadData() {
        presenter?.getRecipesFromNetwork(search: nil)
    }
}

// MARK: - RecepeCategoryView + RecepeCategoryViewProtocol

extension RecepeCategoryView: RecepeCategoryViewProtocol {
    func reloadTableView() {
        tableView.reloadData()
        tableView.isHidden = false
        errorView.isHidden = true
    }

    func setNoDataView() {
        configureErrorView()
        errorLabel.text = Constants.noDataText
    }

    func setErrorView() {
        configureErrorView()
        errorLabel.text = Constants.textError
    }
}

// MARK: - RecepeCategoryView + SortPickerViewDataSource

extension RecepeCategoryView: SortPickerViewDataSource {
    func sortPickerAction(indexPath: IndexPath, newSortState: SortState) {
        presenter?.selectedSort(sortTypes[indexPath.row], newSortState: newSortState)
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
        switch presenter?.getRecipeCount() {
        case let .data(recipes):
            tableView.isScrollEnabled = true
            tableView.allowsSelection = true
            return recipes.count
        default:
            tableView.isScrollEnabled = false
            tableView.allowsSelection = false
            return 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecipeCell.identifier,
            for: indexPath
        ) as? RecipeCell else { return UITableViewCell() }
        switch presenter?.getRecipeInfo() {
        case let .data(recipes):
            cell.loadInfo(recipe: recipes[indexPath.row])
            presenter?.loadImageDataForCell(recipes[indexPath.row].image) { data in
                DispatchQueue.main.async {
                    cell.setImage(imageData: data)
                }
            }
        default:
            cell.loadInfo(recipe: nil)
        }
        return cell
    }
}

// MARK: - RecepeCategoryView + UITableViewDelegate

extension RecepeCategoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToRecipeDetail(numberOfRecipe: indexPath.row)
        tableView.cellForRow(at: indexPath)?.isSelected = true
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

// MARK: - RecepeCategoryView + UISearchBarDelegate

extension RecepeCategoryView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchRecipes(withText: searchText.count >= 3 ? searchText : "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchRecipes(withText: "")
    }
}
