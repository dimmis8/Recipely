// RecipesCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка каталога рецептов
final class RecipesCollectionViewCell: UICollectionViewCell {
    // MARK: - Puplic Properties

    let identifier = "cell"

    // MARK: - Visual Components

    private let recipesButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        return button
    }()

    private let darkTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkTitleView
        return view
    }()

    private let darkTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Any recipe"
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
        addActionRecipeButtonTapped()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func addActionRecipeButtonTapped() {
        recipesButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    private func setupCell() {
        contentView.layer.cornerRadius = 18
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.5
    }

    private func setupVeiew() {
        contentView.addSubview(recipesButton)
        recipesButton.addSubview(darkTitleView)
        darkTitleView.addSubview(darkTitleLabel)
    }

    private func setConstraints() {
        makeRecipesButtonConstraints()
        makeDarkTitleViewConstraints()
        makeDarkTitleLabelConstraints()
    }

    private func makeRecipesButtonConstraints() {
        recipesButton.translatesAutoresizingMaskIntoConstraints = false
        recipesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipesButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipesButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    private func makeDarkTitleViewConstraints() {
        darkTitleView.translatesAutoresizingMaskIntoConstraints = false
        darkTitleView.leadingAnchor.constraint(equalTo: recipesButton.leadingAnchor).isActive = true
        darkTitleView.trailingAnchor.constraint(equalTo: recipesButton.trailingAnchor).isActive = true
        darkTitleView.bottomAnchor.constraint(equalTo: recipesButton.bottomAnchor).isActive = true
        darkTitleView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 5).isActive = true
    }

    private func makeDarkTitleLabelConstraints() {
        darkTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        darkTitleLabel.leadingAnchor.constraint(equalTo: darkTitleView.leadingAnchor).isActive = true
        darkTitleLabel.trailingAnchor.constraint(equalTo: darkTitleView.trailingAnchor).isActive = true
        darkTitleLabel.bottomAnchor.constraint(equalTo: darkTitleView.bottomAnchor).isActive = true
        darkTitleLabel.topAnchor.constraint(equalTo: darkTitleView.topAnchor).isActive = true
    }

    @objc private func addButtonTapped() {
        darkTitleLabel.backgroundColor = .tappedButtonAlpha
        recipesButton.layer.borderWidth = 2
        recipesButton.layer.borderColor = .init(red: 114 / 255, green: 186 / 255, blue: 191 / 255, alpha: 1)
    }

    func setInfo(info: DishCategory) {
        recipesButton.setImage(UIImage(named: info.imageName), for: .normal)
        darkTitleLabel.text = info.type.rawValue
    }
}
