// RecipesCharacteristicsDetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с характеристиками блюда
final class RecipesCharacteristicsDetailsCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let enercKcal = "Enerc kcal"
        static let carbohydrates = "Carbohydrates"
        static let fats = "Fats"
        static let proteins = "Proteins"
    }

    // MARK: - Puplic Properties

    static let identifier = "RecipesCharacteristicsDetailsCell"

    // MARK: - Private Properties

    private let enercView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.characteristics.cgColor
        view.backgroundColor = .characteristics
        return view
    }()

    private let carbohydratesView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.characteristics.cgColor
        view.backgroundColor = .characteristics
        return view
    }()

    private let fatsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.characteristics.cgColor
        view.backgroundColor = .characteristics
        return view
    }()

    private let proteinsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.characteristics.cgColor
        view.backgroundColor = .characteristics
        return view
    }()

    private let enercSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let carbohydratesSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let fatsSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let proteinsSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let enercViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        label.text = Constants.enercKcal
        return label
    }()

    private let enercSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .characteristics
        return label
    }()

    private let carbohydratesViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        label.text = Constants.carbohydrates
        return label
    }()

    private let carbohydratesSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .characteristics
        return label
    }()

    private let fatsViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        label.text = Constants.fats
        return label
    }()

    private let fatsSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .characteristics
        return label
    }()

    private let proteinsViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .white
        label.text = Constants.proteins
        return label
    }()

    private let proteinsSubViewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .verdana(ofSize: 10)
        label.textColor = .characteristics
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

    // MARK: - Public Methods

    func getCharacteristics(recipe: Recipe) {
        enercSubViewLabel.text = "\(recipe.calories) kkal"
        carbohydratesSubViewLabel.text = "\(recipe.carbohydrates) g"
        fatsSubViewLabel.text = "\(recipe.fats) g"
        proteinsSubViewLabel.text = "\(recipe.proteins) g"
    }

    // MARK: - Private Methods

    private func setUp() {
        setupView()
        setConstraints()
        contentView.backgroundColor = .white
    }

    private func setupView() {
        contentView.clipsToBounds = true
        contentView.addSubview(enercView)
        enercView.addSubview(enercSubView)
        contentView.addSubview(carbohydratesView)
        carbohydratesView.addSubview(carbohydratesSubView)
        contentView.addSubview(fatsView)
        fatsView.addSubview(fatsSubView)
        contentView.addSubview(proteinsView)
        proteinsView.addSubview(proteinsSubView)

        enercView.addSubview(enercViewLabel)
        enercSubView.addSubview(enercSubViewLabel)
        carbohydratesView.addSubview(carbohydratesViewLabel)
        carbohydratesSubView.addSubview(carbohydratesSubViewLabel)
        fatsView.addSubview(fatsViewLabel)
        fatsSubView.addSubview(fatsSubViewLabel)
        proteinsView.addSubview(proteinsViewLabel)
        proteinsSubView.addSubview(proteinsSubViewLabel)
    }

    private func setConstraints() {
        makeEnercViewConstraints()
        makeCarbohydratesViewConstraints()
        makeFatsViewConstraints()
        makeProteinsViewConstraints()
        makeEnercSubViewConstraints()
        makeCarbohydratesSubViewConstraints()
        makeFatsSubViewConstraints()
        makeProteinsSubViewConstraints()
        makeEnercViewLabelConstraints()
        makeCarbohydratesViewLabelConstraints()
        makeFatsViewLabelConstraints()
        makeProteinsViewLabelConstraints()
        makeEnercSubViewLabelConstraints()
        makeCarbohydratesSubViewLabelConstraints()
        makeFatsSubViewLabelConstraints()
        makeProteinsSubViewLabelConstraints()
    }

    private func makeEnercViewConstraints() {
        enercView.translatesAutoresizingMaskIntoConstraints = false
        enercView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        enercView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        enercView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        enercView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        enercView.heightAnchor.constraint(equalToConstant: 53).isActive = true
    }

    private func makeCarbohydratesViewConstraints() {
        carbohydratesView.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesView.leadingAnchor.constraint(equalTo: enercView.trailingAnchor, constant: 5).isActive = true
        carbohydratesView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        carbohydratesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        carbohydratesView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        carbohydratesView.heightAnchor.constraint(equalToConstant: 53).isActive = true
    }

    private func makeFatsViewConstraints() {
        fatsView.translatesAutoresizingMaskIntoConstraints = false
        fatsView.leadingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor, constant: 5).isActive = true
        fatsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        fatsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        fatsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        fatsView.heightAnchor.constraint(equalToConstant: 53).isActive = true
    }

    private func makeProteinsViewConstraints() {
        proteinsView.translatesAutoresizingMaskIntoConstraints = false
        proteinsView.leadingAnchor.constraint(equalTo: fatsView.trailingAnchor, constant: 5).isActive = true
        proteinsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        proteinsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        proteinsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        proteinsView.heightAnchor.constraint(equalToConstant: 53).isActive = true
    }

    private func makeEnercSubViewConstraints() {
        enercSubView.translatesAutoresizingMaskIntoConstraints = false
        enercSubView.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercSubView.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercSubView.bottomAnchor.constraint(equalTo: enercView.bottomAnchor).isActive = true
        enercSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeCarbohydratesSubViewConstraints() {
        carbohydratesSubView.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesSubView.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesSubView.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesSubView.bottomAnchor.constraint(equalTo: carbohydratesView.bottomAnchor).isActive = true
        carbohydratesSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeFatsSubViewConstraints() {
        fatsSubView.translatesAutoresizingMaskIntoConstraints = false
        fatsSubView.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsSubView.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsSubView.bottomAnchor.constraint(equalTo: fatsView.bottomAnchor).isActive = true
        fatsSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeProteinsSubViewConstraints() {
        proteinsSubView.translatesAutoresizingMaskIntoConstraints = false
        proteinsSubView.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsSubView.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsSubView.bottomAnchor.constraint(equalTo: proteinsView.bottomAnchor).isActive = true
        proteinsSubView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func makeEnercViewLabelConstraints() {
        enercViewLabel.translatesAutoresizingMaskIntoConstraints = false
        enercViewLabel.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercViewLabel.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercViewLabel.topAnchor.constraint(equalTo: enercView.topAnchor, constant: 8).isActive = true
        enercViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func makeCarbohydratesViewLabelConstraints() {
        carbohydratesViewLabel.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesViewLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesViewLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesViewLabel.topAnchor.constraint(equalTo: carbohydratesView.topAnchor, constant: 8).isActive = true
        carbohydratesViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func makeFatsViewLabelConstraints() {
        fatsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsViewLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsViewLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsViewLabel.topAnchor.constraint(equalTo: fatsView.topAnchor, constant: 8).isActive = true
        fatsViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func makeProteinsViewLabelConstraints() {
        proteinsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinsViewLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsViewLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsViewLabel.topAnchor.constraint(equalTo: proteinsView.topAnchor, constant: 8).isActive = true
        proteinsViewLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }

    private func makeEnercSubViewLabelConstraints() {
        enercSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        enercSubViewLabel.leadingAnchor.constraint(equalTo: enercView.leadingAnchor).isActive = true
        enercSubViewLabel.trailingAnchor.constraint(equalTo: enercView.trailingAnchor).isActive = true
        enercSubViewLabel.bottomAnchor.constraint(equalTo: enercView.bottomAnchor, constant: -4).isActive = true
        enercSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func makeCarbohydratesSubViewLabelConstraints() {
        carbohydratesSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        carbohydratesSubViewLabel.leadingAnchor.constraint(equalTo: carbohydratesView.leadingAnchor).isActive = true
        carbohydratesSubViewLabel.trailingAnchor.constraint(equalTo: carbohydratesView.trailingAnchor).isActive = true
        carbohydratesSubViewLabel.bottomAnchor.constraint(equalTo: carbohydratesView.bottomAnchor, constant: -4)
            .isActive = true
        carbohydratesSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func makeFatsSubViewLabelConstraints() {
        fatsSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsSubViewLabel.leadingAnchor.constraint(equalTo: fatsView.leadingAnchor).isActive = true
        fatsSubViewLabel.trailingAnchor.constraint(equalTo: fatsView.trailingAnchor).isActive = true
        fatsSubViewLabel.bottomAnchor.constraint(equalTo: fatsView.bottomAnchor, constant: -4).isActive = true
        fatsSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func makeProteinsSubViewLabelConstraints() {
        proteinsSubViewLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinsSubViewLabel.leadingAnchor.constraint(equalTo: proteinsView.leadingAnchor).isActive = true
        proteinsSubViewLabel.trailingAnchor.constraint(equalTo: proteinsView.trailingAnchor).isActive = true
        proteinsSubViewLabel.bottomAnchor.constraint(equalTo: proteinsView.bottomAnchor, constant: -4).isActive = true
        proteinsSubViewLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
