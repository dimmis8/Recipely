// RecipesDescriptionDetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием приготовления
class RecipesDescriptionDetailsCell: UITableViewCell {
    // MARK: - Puplic Properties

    static let identifier = "RecipesDescriptionDetailsCell"

    // MARK: - Visual Components

    private let gradientLayer = CAGradientLayer()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.font = .verdana(ofSize: 14)
        textView.isEditable = false
        return textView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
<<<<<<< HEAD
        createView()
        setConstraints()
    }

    // MARK: - Public Methods

    func setText(_ text: String) {
        textView.text = text
    }

    func addGradient() {
        gradientLayer.frame = CGRect(
            x: 0,
            y: 10,
            width: contentView.bounds.width,
            height: contentView.bounds.height - 10
        )
        let path = UIBezierPath(
            roundedRect: contentView.bounds,
            byRoundingCorners: [.topRight, .topLeft],
            cornerRadii: CGSize(width: 24, height: 24)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        gradientLayer.mask = maskLayer
    }

    // MARK: - Private Methods

    private func createView() {
        gradientLayer.colors = [UIColor.loginGradient.cgColor, UIColor.white.cgColor]
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubview(textView)
    }

    private func setConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
=======
>>>>>>> b1b5346 (Добавлены ячейки таблицы)
    }
}
