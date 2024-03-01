// RecipesImageDetailCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой блюда
class RecipesImageDetailCell: UITableViewCell {
    // MARK: - Puplic Properties

    static let identifier = "RecipesImageDetailCell"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .blue
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
