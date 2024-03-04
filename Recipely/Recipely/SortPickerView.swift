// SortPickerView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол датасорса пикера сортировки
protocol SortPickerViewDataSource {
    /// Количество кнопок пикера
    func sortPickerCount(_ sortPicker: SortPickerView) -> Int
    /// Тайтлы для кнопок пикера
    func sortPickerTitle(_ sortPicker: SortPickerView, indexPath: IndexPath) -> String
    /// Картинка для кнопки пикера при нажатии на нее
    func sortPickerImage(indexPath: IndexPath) -> (String, Bool)
}

/// Пикер сортировки
final class SortPickerView: UIControl {
    // MARK: - Public Properties

    public var dataSource: SortPickerViewDataSource? {
        didSet {
            setupView()
        }
    }

    // MARK: - Private Properties

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Public Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    // MARK: - Private Methods

    func setupView() {
        let count = dataSource?.sortPickerCount(self)
        for item in 0 ..< (count ?? 1) {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.sortPickerTitle(self, indexPath: indexPath)
            let button = UIButton()
            button.setTitle("\(title ?? "") ", for: .normal)
            button.tag = item
            button.layer.cornerRadius = 18
            button.titleLabel?.font = .verdana(ofSize: 14)
            button.contentVerticalAlignment = .center
            button.backgroundColor = .backgroundTeal
            button.semanticContentAttribute = .forceRightToLeft
            button.setTitleColor(.black, for: .normal)
            button.setImage(.sortDirection, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.setImage(.whiteSortDirection, for: .selected)
            button.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
            buttons.append(button)
            addSubview(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
    }

    @objc private func selectedButton(sender: UIButton) {
        let selectedButton = buttons[sender.tag]
        guard let (newImageName, isSelected) = dataSource?.sortPickerImage(
            indexPath: IndexPath(row: sender.tag, section: 0)
        ) else { return }

        selectedButton.setImage(UIImage(named: newImageName), for: .selected)
        selectedButton.isSelected = isSelected
        selectedButton.backgroundColor = isSelected ? .selectedTitle : .backgroundTeal
    }
}
