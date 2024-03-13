// RecipesImageDetailCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой блюда
final class RecipesImageDetailCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let cookingTime = "Cooking time"
    }

    // MARK: - Puplic Properties

    static let identifier = "RecipesImageDetailCell"

    // MARK: - Private Properties

    private let recipeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        return imageView
    }()

    private let iconGram: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pot
        return imageView
    }()

    private let iconCookingTime: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timerDetails
        return imageView
    }()

    private let gramView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .detailsBackView
        return view
    }()

    private let cookingTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .detailsBackView
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()

    private let gramLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        return label
    }()

    private let cookingTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        label.text = Constants.cookingTime
        return label
    }()

    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        return label
    }()

    // MARK: - Private Properties

    private var isShimming = true

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isShimming {
            recipeImage.startShimmeringAnimation()
        }
        iconGram.isHidden = isShimming
        iconCookingTime.isHidden = isShimming
        gramView.isHidden = isShimming
        cookingTimeView.isHidden = isShimming
        gramLabel.isHidden = isShimming
        cookingTimeTitleLabel.isHidden = isShimming
        cookingTimeLabel.isHidden = isShimming
    }

    // MARK: - Public Methods

    func getInfo(recipe: RecipeDetails?) {
        if let recipe = recipe {
            isShimming = false
            recipeImage.stopShimmeringAnimation()
            gramLabel.text = recipe.weight
            cookingTimeLabel.text = "\(recipe.totalTime) min"
        } else {
            isShimming = true
        }
    }

    func setImage(imageData: Data) {
        recipeImage.image = UIImage(data: imageData)
    }

    // MARK: - Private Methods

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
        cookingTimeView.addSubview(iconCookingTime)
        cookingTimeView.addSubview(cookingTimeTitleLabel)
        cookingTimeView.addSubview(cookingTimeLabel)
    }

    private func setConstraints() {
        makeRecipeImageConstraints()
        makeGramViewConstraints()
        makeiconGramConstraints()
        makeGramLabelConstraints()
        makeCookingTimeViewConstraints()
        makeIconCookingTimeConstraints()
        makeCookingTimeTitleLabelConstraints()
        makeCookingTimeLabelConstraints()
    }

    private func makeRecipeImageConstraints() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
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

    private func makeIconCookingTimeConstraints() {
        iconCookingTime.translatesAutoresizingMaskIntoConstraints = false
        iconCookingTime.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 8).isActive = true
        iconCookingTime.leadingAnchor.constraint(equalTo: cookingTimeView.leadingAnchor, constant: 12).isActive = true
        iconCookingTime.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconCookingTime.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

    private func makeCookingTimeTitleLabelConstraints() {
        cookingTimeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeTitleLabel.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 10).isActive = true
        cookingTimeTitleLabel.trailingAnchor.constraint(equalTo: cookingTimeView.trailingAnchor, constant: -8)
            .isActive = true
        cookingTimeTitleLabel.widthAnchor.constraint(equalToConstant: 83).isActive = true
        cookingTimeTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func makeCookingTimeLabelConstraints() {
        cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeLabel.topAnchor.constraint(equalTo: cookingTimeTitleLabel.bottomAnchor).isActive = true
        cookingTimeLabel.leadingAnchor.constraint(equalTo: iconCookingTime.trailingAnchor, constant: 15).isActive = true
        cookingTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
