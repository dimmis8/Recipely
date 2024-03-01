// RecipesImageDetailCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой блюда
class RecipesImageDetailCell: UITableViewCell {
    // MARK: - Puplic Properties

    static let identifier = "RecipesImageDetailCell"

    // MARK: - Private Properties

    let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    let iconGram: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pot
        return imageView
    }()

    let iconCookingTime: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerDetails
        return imageView
    }()

    let gramView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .detailsBackView
        return view
    }()

    let cookingTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .detailsBackView
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()

    let gramLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        return label
    }()

    let cookingTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        return label
    }()

    let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    // MARK: - Private Methods

    func getInfo(recipe: Recipe) {
        recipeImage.image = UIImage(named: recipe.imageName)
        gramLabel.text = String(recipe.weight)
    }

    private func setUp() {
        setupView()
        setConstraints()
    }

    private func setupView() {
        contentView.clipsToBounds = true
        contentView.addSubview(recipeImage)
        recipeImage.addSubview(gramView)
        gramView.addSubview(iconGram)
        gramView.addSubview(gramLabel)
        recipeImage.addSubview(cookingTimeView)
    }

    private func setConstraints() {
        makeRecipeImageConstraints()
        makeGramViewConstraints()
        makeiconGramConstraints()
        makeGramLabelConstraints()
        makeCookingTimeViewConstraints()
    }

    private func makeRecipeImageConstraints() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45).isActive = true
        recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipeImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func makeGramViewConstraints() {
        gramView.translatesAutoresizingMaskIntoConstraints = false
        gramView.topAnchor.constraint(equalTo: recipeImage.topAnchor, constant: 12).isActive = true
        gramView.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: -10).isActive = true
        gramView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gramView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func makeiconGramConstraints() {
        iconGram.translatesAutoresizingMaskIntoConstraints = false
        iconGram.topAnchor.constraint(equalTo: gramView.topAnchor, constant: 7).isActive = true
        iconGram.trailingAnchor.constraint(equalTo: gramView.trailingAnchor, constant: -15).isActive = true
        iconGram.widthAnchor.constraint(equalToConstant: 20).isActive = true
        iconGram.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }

    private func makeGramLabelConstraints() {
        gramLabel.translatesAutoresizingMaskIntoConstraints = false
        gramLabel.topAnchor.constraint(equalTo: gramView.topAnchor, constant: 28).isActive = true
        gramLabel.leadingAnchor.constraint(equalTo: gramView.leadingAnchor, constant: 6).isActive = true
        gramLabel.widthAnchor.constraint(equalToConstant: 39).isActive = true
        gramLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func makeCookingTimeViewConstraints() {
        cookingTimeView.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeView.bottomAnchor.constraint(equalTo: recipeImage.bottomAnchor).isActive = true
        cookingTimeView.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor).isActive = true
        cookingTimeView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        cookingTimeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
