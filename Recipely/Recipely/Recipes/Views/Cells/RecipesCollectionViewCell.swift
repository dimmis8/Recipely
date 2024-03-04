// RecipesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка каталога рецептов
final class RecipesCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    static let identifier = "RecipesCollectionViewCell"

    // MARK: - Visual Components

    private let recipesImageView: UIImageView = {
        let button = UIImageView()
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()

    private let darkTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkTitleView
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupVeiew()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupVeiew()
        setConstraints()
    }

    // MARK: - Private Methods

    private func setupCell() {
        contentView.layer.cornerRadius = 18
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.5
    }

    private func setupVeiew() {
        contentView.addSubview(recipesImageView)
        recipesImageView.addSubview(darkTitleView)
        darkTitleView.addSubview(titleLabel)
    }

    private func setConstraints() {
        makeRecipesButtonConstraints()
        makeDarkTitleViewConstraints()
        makeDarkTitleLabelConstraints()
    }

    private func makeRecipesButtonConstraints() {
        recipesImageView.translatesAutoresizingMaskIntoConstraints = false
        recipesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipesImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    private func makeDarkTitleViewConstraints() {
        darkTitleView.translatesAutoresizingMaskIntoConstraints = false
        darkTitleView.leadingAnchor.constraint(equalTo: recipesImageView.leadingAnchor).isActive = true
        darkTitleView.trailingAnchor.constraint(equalTo: recipesImageView.trailingAnchor).isActive = true
        darkTitleView.bottomAnchor.constraint(equalTo: recipesImageView.bottomAnchor).isActive = true
        darkTitleView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 5).isActive = true
    }

    private func makeDarkTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: darkTitleView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: darkTitleView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: darkTitleView.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: darkTitleView.topAnchor).isActive = true
    }

    @objc private func addButtonTapped() {
        titleLabel.backgroundColor = .tappedButtonAlpha
        recipesImageView.layer.borderWidth = 2
        recipesImageView.layer.borderColor = UIColor.tappedButtonBounds.cgColor
    }

    func setInfo(info: DishCategory) {
        recipesImageView.image = UIImage(named: info.imageName)
        titleLabel.text = info.type.rawValue
        if contentView.frame.width < 150 {
            titleLabel.font = .verdana(ofSize: 16)
        } else {
            titleLabel.font = .verdana(ofSize: 20)
        }
    }
}
