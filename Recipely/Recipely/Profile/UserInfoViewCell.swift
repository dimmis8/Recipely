// UserInfoViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о пользователе
final class UserInfoViewCell: UITableViewCell {
    // MARK: - Constants

    enum Constants {
        static let profilePhotoHeigh: CGFloat = 160
    }

    // MARK: - Visual Components

    private let profilePhotoButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.profilePhotoHeigh / 2
        button.layer.borderWidth = 3
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.selectedTitle.cgColor
        return button
    }()

    private let nameView: UIView = {
        let nameView = UIView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        return nameView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .dirtyGreen
        label.font = .init(name: "Verdana-Bold", size: 25)
        return label
    }()

    private let changeNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.pencil, for: .normal)
        return button
    }()

    // MARK: - Private Properties

    private var buttonChangeHandler: (() -> ())?
    private var buttonChangePhotoHandler: (() -> ())?

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createView()
        setConstraints()
    }

    // MARK: - Public Methods

    func setUserInformation(
        _ userInfo: UserInfo,
        changeNameComplition: @escaping () -> (),
        changePhotoComplition: @escaping () -> ()
    ) {
        profilePhotoButton.setImage(UIImage(named: userInfo.userPhotoName), for: .normal)
        profilePhotoButton.imageView?.clipsToBounds = true
        profilePhotoButton.imageView?.contentMode = .scaleAspectFill
        fullNameLabel.text = "\(userInfo.nameSurname)"
        buttonChangeHandler = changeNameComplition
        buttonChangePhotoHandler = changePhotoComplition
    }

    // MARK: - Private Methods

    private func createView() {
        contentView.backgroundColor = .white
        contentView.addSubview(profilePhotoButton)
        nameView.addSubview(fullNameLabel)
        nameView.addSubview(changeNameButton)
        contentView.addSubview(nameView)
        changeNameButton.addTarget(self, action: #selector(changeNameTapped), for: .touchUpInside)
        profilePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
    }

    private func setConstraints() {
        setProfilePhotoImageViewConstraints()
        setfullNameLabelConstraints()
        setChangeNameButtonConstraints()
        setNameViewConstraints()
    }

    private func setProfilePhotoImageViewConstraints() {
        profilePhotoButton.heightAnchor.constraint(equalToConstant: Constants.profilePhotoHeigh).isActive = true
        profilePhotoButton.widthAnchor.constraint(equalToConstant: Constants.profilePhotoHeigh).isActive = true
        profilePhotoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profilePhotoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
    }

    private func setfullNameLabelConstraints() {
        fullNameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: nameView.topAnchor).isActive = true
        fullNameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor).isActive = true
        fullNameLabel.trailingAnchor.constraint(equalTo: changeNameButton.leadingAnchor, constant: -8).isActive = true
    }

    private func setChangeNameButtonConstraints() {
        changeNameButton.trailingAnchor.constraint(equalTo: nameView.trailingAnchor).isActive = true
        changeNameButton.topAnchor.constraint(equalTo: nameView.topAnchor).isActive = true
        changeNameButton.bottomAnchor.constraint(equalTo: nameView.bottomAnchor).isActive = true
        changeNameButton.widthAnchor.constraint(equalTo: changeNameButton.widthAnchor).isActive = true
    }

    private func setNameViewConstraints() {
        nameView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: profilePhotoButton.bottomAnchor, constant: 26).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29).isActive = true
    }

    @objc func changeNameTapped() {
        buttonChangeHandler?()
    }

    @objc func changePhotoTapped() {
        buttonChangePhotoHandler?()
    }
}
