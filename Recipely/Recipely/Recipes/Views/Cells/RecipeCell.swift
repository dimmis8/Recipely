// RecipeCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рецептом
final class RecipeCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = "RecipeCell"

    // MARK: - Visual Components

    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundTeal
        view.layer.cornerRadius = 12
        return view
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    private let recipeLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private let timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .timer
        return imageView
    }()

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 12)
        return label
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .pizza
        return imageView
    }()

    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = .verdana(ofSize: 12)
        return label
    }()

    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .detailsIcon
        return imageView
    }()

    private let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }()

    private let shimmersView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .systemGray6
        view.isHidden = true
        return view
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        setConstraints()
        makeShimmer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods

    func loadInfo(recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        recipeLabel.text = recipe.title
        timerLabel.text = "\(recipe.cookTime) min"
        caloriesLabel.text = "\(recipe.calories) kkal"
    }

    // MARK: - Private Methods

    private func createView() {
        selectionStyle = .none

        contentView.addSubview(background)
        contentView.addSubview(shimmersView)
        background.addSubview(recipeImageView)
        background.addSubview(recipeLabel)
        background.addSubview(timerImageView)
        background.addSubview(timerLabel)
        background.addSubview(pizzaImageView)
        background.addSubview(caloriesLabel)
        background.addSubview(detailImageView)
    }

    private func setConstraints() {
        setShimmersViewConstraints()
        setBackgroundViewConstraints()
        setRecipeImageViewConstraints()
        setRecipeLabelConstraints()
        setTimerImageViewConstraints()
        setTimerLabelConstraints()
        setPizzaImageViewConstraints()
        setCaloriesLabelConstraints()
        setDetailImageViewConstraints()
    }

    private func setShimmersViewConstraints() {
        shimmersView.translatesAutoresizingMaskIntoConstraints = false
        shimmersView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        shimmersView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        shimmersView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        shimmersView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        shimmersView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func setBackgroundViewConstraints() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        background.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true
        background.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func setRecipeImageViewConstraints() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 10).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setRecipeLabelConstraints() {
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        recipeLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        recipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -43).isActive = true
        recipeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func setTimerImageViewConstraints() {
        timerImageView.translatesAutoresizingMaskIntoConstraints = false
        timerImageView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 8).isActive = true
        timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20).isActive = true
        timerImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        timerImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setTimerLabelConstraints() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.topAnchor.constraint(equalTo: timerImageView.topAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 4).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 55).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setPizzaImageViewConstraints() {
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        pizzaImageView.topAnchor.constraint(equalTo: timerImageView.topAnchor).isActive = true
        pizzaImageView.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 10).isActive = true
        pizzaImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        pizzaImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCaloriesLabelConstraints() {
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        caloriesLabel.topAnchor.constraint(equalTo: timerImageView.topAnchor).isActive = true
        caloriesLabel.leadingAnchor.constraint(equalTo: pizzaImageView.trailingAnchor, constant: 4).isActive = true
        caloriesLabel.widthAnchor.constraint(equalToConstant: 72).isActive = true
        caloriesLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setDetailImageViewConstraints() {
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        detailImageView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -2).isActive = true
        detailImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        detailImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func makeShimmer() {
        Timer.scheduledTimer(
            timeInterval: 3.0,
            target: self,
            selector: #selector(loadingHandler),
            userInfo: nil,
            repeats: false
        )
        shimmersView.isHidden = false
        startShimmeringAnimation()
    }

    @objc private func loadingHandler() {
        shimmersView.isHidden = true
        stopShimmeringAnimation()
    }
}

extension UIView {
    // ->1
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }

    func startShimmeringAnimation(
        animationSpeed: Float = 1.4,
        direction: Direction = .leftToRight,
        repeatCount: Float = MAXFLOAT
    ) {
        // Create color  ->2
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor

        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: -bounds.size.height,
            width: 3 * bounds.size.width,
            height: 4 * bounds.size.height
        )

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        gradientLayer.locations = [0.35, 0.50, 0.1] // [0.4, 0.6]
        layer.mask = gradientLayer

        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }

    func stopShimmeringAnimation() {
        layer.mask = nil
    }
}
