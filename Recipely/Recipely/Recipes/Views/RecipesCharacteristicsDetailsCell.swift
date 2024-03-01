// RecipesCharacteristicsDetailsCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с характеристиками блюда
class RecipesCharacteristicsDetailsCell: UITableViewCell {
    // MARK: - Puplic Properties

    static let identifier = "RecipesCharacteristicsDetailsCell"

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
