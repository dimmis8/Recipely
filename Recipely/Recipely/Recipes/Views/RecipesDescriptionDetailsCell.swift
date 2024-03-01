// RecipesDescriptionDetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием приготовления
class RecipesDescriptionDetailsCell: UITableViewCell {
    // MARK: - Puplic Properties

    static let identifier = "RecipesDescriptionDetailsCell"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .orange
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
