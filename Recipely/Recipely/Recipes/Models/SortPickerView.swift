// SortPickerView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol SortPickerViewDataSource {
    func sortPickerCount(_ sortPicker: SortPickerView) -> Int
    func sortPickerTitle(_ sortPicker: SortPickerView, indexPath: IndexPath) -> String
    func sortPickerImage(indexPath: IndexPath, beforeSelected: Bool) -> String
}

/// Пикер дня
class SortPickerView: UIControl {
    public var dataSource: SortPickerViewDataSource? {
        didSet {
            setupView()
        }
    }

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupView() {
        let count = dataSource?.sortPickerCount(self)
        for item in 0 ..< (count ?? 1) {
            let indexPath = IndexPath(row: item, section: 0)
            let title = dataSource?.sortPickerTitle(self, indexPath: indexPath)
            let button = UIButton()
            button.setTitle("\(title ?? "") ", for: .normal)
            button.tag = item
            button.layer.cornerRadius = 18
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

    @objc func selectedButton(sender: UIButton) {
        let selectedButton = buttons[sender.tag]
        let newImageName = dataSource?.sortPickerImage(
            indexPath: IndexPath(row: sender.tag, section: 0),
            beforeSelected: selectedButton.isSelected
        )
        selectedButton.setImage(UIImage(named: newImageName ?? ""), for: .selected)
        for button in buttons {
            button.isSelected = false
            button.backgroundColor = .backgroundTeal
        }
        selectedButton.isSelected = true
        selectedButton.backgroundColor = .selectedTitle
    }
}
