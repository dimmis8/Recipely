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

    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.profilePhotoHeigh / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.selectedTitle.cgColor
        imageView.clipsToBounds = true
        return imageView
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

    // MARK: - Public Properties

    func setUserInformation(_ userInfo: UserInfo) {
        profilePhotoImageView.image = UIImage(named: userInfo.userPhotoName)
        fullNameLabel.text = "\(userInfo.nameSurname)"
    }

    // MARK: - Private Methods

    private func createView() {
        contentView.backgroundColor = .white
        contentView.addSubview(profilePhotoImageView)
        nameView.addSubview(fullNameLabel)
        nameView.addSubview(changeNameButton)
        contentView.addSubview(nameView)
    }

    private func setConstraints() {
        setProfilePhotoImageViewConstraints()
        setfullNameLabelConstraints()
        setChangeNameButtonConstraints()
        setNameViewConstraints()
    }

    private func setProfilePhotoImageViewConstraints() {
        profilePhotoImageView.heightAnchor.constraint(equalToConstant: Constants.profilePhotoHeigh).isActive = true
        profilePhotoImageView.widthAnchor.constraint(equalToConstant: Constants.profilePhotoHeigh).isActive = true
        profilePhotoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        profilePhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
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
        nameView.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 26).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -29).isActive = true
    }
}
