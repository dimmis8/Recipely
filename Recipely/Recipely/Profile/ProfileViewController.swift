// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let viewTitleText = "Profile"
    }

    // MARK: - Public Properties

    var presenter: ProfileViewPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        view.backgroundColor = .white
        configureNavigationItem()
    }

    private func configureNavigationItem() {
        navigationItem.title = Constants.viewTitleText
    }
}

// MARK: - Подписание на протокол экрана профиля

extension ProfileViewController: ProfileViewProtocol {}
