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
    // MARK: - Constants

    enum Constants {
        static let viewTitleText = "Recipes"
        static let numberOfCellsInPattern = 7
    }

    // MARK: - Visual Components

    let recipesLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.viewTitleText
        label.font = .verdanaBold(ofSize: 28)
        return label
    }()

    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Public Properties

    var presenter: RecipesViewPresenterProtocol?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupCollectionView()
        collectionView.backgroundColor = .white
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deselectedSelectedRow()
    }

    // MARK: - Private Methods

    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: recipesLabel)
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }

    private func setConstraints() {
        makeCollectionViewConstraints()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            RecipesCollectionViewCell.self,
            forCellWithReuseIdentifier: RecipesCollectionViewCell.identifier
        )
    }

    private func makeCollectionViewConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func deselectedSelectedRow() {
        if let selectedIndex = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: selectedIndex, animated: false)
        }
    }
}

// MARK: - Extension UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    /// количество элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getCategoryCount() ?? 0
    }

    /// создание и настройка ячейки
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let category = presenter?.getInfo(categoryNumber: indexPath.item)
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: RecipesCollectionViewCell.identifier,
                for: indexPath
            ) as? RecipesCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setInfo(info: category ?? DishCategory(imageName: "", type: .chicken))
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % Constants.numberOfCellsInPattern

        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width - 140
        case 3 ... 5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = 0
        }
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToCategory(.fish)
    }
}

// MARK: - RecipesViewController + RecipesViewProtocol

extension RecipesViewController: RecipesViewProtocol {}
