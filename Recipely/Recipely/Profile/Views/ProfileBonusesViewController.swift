// ProfileBonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран бонусов пользвателя
final class ProfileBonusesViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let bonusesText = "Your bonuses"
        static let verdanaBold = "Verdana-Bold"
    }

    // MARK: - Visual Components

    private let yourBonusesLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bonusesText
        label.font = UIFont(name: Constants.verdanaBold, size: 20)
        label.textColor = .dirtyGreen
        label.textAlignment = .center
        return label
    }()

    private lazy var bonusesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.verdanaBold, size: 30)
        label.textColor = .dirtyGreen
        label.textAlignment = .left
        return label
    }()

    private let bonusesBoxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bonusesBox
        return imageView
    }()

    private let bonusesStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .bonusesStar
        return imageView
    }()

    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(.dismissButton, for: .normal)
        return button
    }()

    // MARK: - Public Properties

    var presenter: ProfileBonusesPresenter!

    // MARK: - Public Properties

    var bonusesCount: Int?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(yourBonusesLabel)
        view.addSubview(bonusesCountLabel)
        view.addSubview(bonusesBoxImageView)
        view.addSubview(bonusesStarImageView)
        view.addSubview(dismissButton)
    }

    private func setupConstraints() {
        makeTapDismissButton()
        makeBonusesLabelConstraints()
        makeBonusesBoxImageViewConstraints()
        makeBonusesStarImageViewConstraints()
        makeBonusesCountLabelConstraints()
        makeDismissButtonConstraints()
    }

    private func makeTapDismissButton() {
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
    }

    private func makeBonusesLabelConstraints() {
        yourBonusesLabel.translatesAutoresizingMaskIntoConstraints = false
        yourBonusesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        yourBonusesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        yourBonusesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 46).isActive = true
        yourBonusesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

    private func makeBonusesBoxImageViewConstraints() {
        bonusesBoxImageView.translatesAutoresizingMaskIntoConstraints = false
        bonusesBoxImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120).isActive = true
        bonusesBoxImageView.topAnchor.constraint(equalTo: yourBonusesLabel.bottomAnchor, constant: 13).isActive = true
        bonusesBoxImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        bonusesBoxImageView.heightAnchor.constraint(equalToConstant: 136).isActive = true
    }

    private func makeBonusesStarImageViewConstraints() {
        bonusesStarImageView.translatesAutoresizingMaskIntoConstraints = false
        bonusesStarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 144).isActive = true
        bonusesStarImageView.topAnchor.constraint(equalTo: bonusesBoxImageView.bottomAnchor, constant: 31)
            .isActive = true
        bonusesStarImageView.widthAnchor.constraint(equalToConstant: 29).isActive = true
        bonusesStarImageView.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }

    private func makeBonusesCountLabelConstraints() {
        bonusesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        bonusesCountLabel.leadingAnchor.constraint(equalTo: bonusesStarImageView.trailingAnchor, constant: 11)
            .isActive = true
        bonusesCountLabel.topAnchor.constraint(equalTo: bonusesBoxImageView.bottomAnchor, constant: 28).isActive = true
        bonusesCountLabel.widthAnchor.constraint(equalToConstant: 177).isActive = true
        bonusesCountLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    private func makeDismissButtonConstraints() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 13).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }

    @objc private func dismissButtonTapped() {
        presenter.dismissSelf()
    }
}

extension ProfileBonusesViewController: ProfileBonusesViewProtocol {
    func setBonuses(bonusesCount: Int) {
        self.bonusesCount = bonusesCount
        bonusesCountLabel.text = String(bonusesCount)
    }
}
