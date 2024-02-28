// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let viewTitleText = "Profile"
        static let userInfoViewCellIdentifier = "UserInfoViewCell"
        static let profileButtonViewCellIdentifire = "ProfileButtonViewCell"
        static let bonusesButtonText = "Bonuses"
        static let termsAndPrivacyButtonText = "Terms & Privacy Policy"
        static let logOutButtonText = "Log out"
        static let alertTitle = "Are you sure you want to log out?"
        static let closeButtonText = "Close"
        static let yesButtonText = "Yes"
        static let cancelButtonText = "Cancel"
        static let okButtonText = "OK"
        static let alertText = "Change your name and surname"
        static let nameSurname = "Name Surname"
        static let termsAndPrivacyAlertMassage = "Functionality in development"
    }

    // MARK: - Visual Components

    private let tableView = UITableView()

    // MARK: - Public Properties

    var presenter: ProfileViewPresenterProtocol!

    // MARK: - Private Properties

    private let contentTypes: [ContentTypes] = [.userInfo, .profileButtons]
    private let buttons: [ButtonType] = [.bonuses, .termsAndPrivacy, .logOut]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationItem()
        configureTableView()
    }

    // MARK: - Private Methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func configureNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.viewTitleText
    }

    private func setNewName(_ newName: String) {
        presenter.editNameSurname(name: newName)
    }

    private func configureTableView() {
        tableView.register(UserInfoViewCell.self, forCellReuseIdentifier: Constants.userInfoViewCellIdentifier)
        tableView.register(
            ProfileButtonViewCell.self,
            forCellReuseIdentifier: Constants.profileButtonViewCellIdentifire
        )
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - Подписание на протокол экрана профиля

extension ProfileViewController: ProfileViewProtocol {
    func showLogOutAlert() {
        let alertController = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: Constants.closeButtonText, style: .default)
        let actionYes = UIAlertAction(title: Constants.yesButtonText, style: .default) { _ in
            self.presenter.logOut()
        }
        alertController.addAction(actionClose)
        alertController.addAction(actionYes)
        present(alertController, animated: true)
    }

    func showChangeNameAlert() {
        let alertView = UIAlertController(title: Constants.alertText, message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constants.cancelButtonText, style: .cancel)
        let okAction = UIAlertAction(title: Constants.okButtonText, style: .default) { _ in
            self.setNewName(alertView.textFields?.first?.text ?? "")
        }
        alertView.addAction(cancelAction)
        alertView.addAction(okAction)
        alertView.addTextField()
        alertView.textFields?.first?.placeholder = Constants.nameSurname
        present(alertView, animated: true)
    }

    func showInDevelopAlert() {
        let alertView = UIAlertController(
            title: Constants.termsAndPrivacyAlertMassage,
            message: "",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: Constants.okButtonText, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }

    func setPhotoFromSource() {
        tableView.reloadData()
    }

    func setNewNameFromSource() {
        tableView.reloadData()
    }
}

// MARK: - Добавление групп контента на экране профиля

extension ProfileViewController {
    enum ContentTypes {
        /// Информация о пользователе
        case userInfo
        /// Кнопки с дополнительными возможностями
        case profileButtons
    }
}

// MARK: - Добавление видов кнопок на экране профиля

extension ProfileViewController {
    enum ButtonType {
        /// Кнопка бонусов
        case bonuses
        /// Кнопка условия эксплуатации
        case termsAndPrivacy
        /// Кнопка выхода
        case logOut
    }
}

// MARK: - Подписание на дата сорс тейбл вью

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        contentTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentTypes[section] {
        case .userInfo:
            return 1
        case .profileButtons:
            return buttons.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentTypes[indexPath.section] {
        case .userInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.userInfoViewCellIdentifier,
                for: indexPath
            ) as? UserInfoViewCell else { return UITableViewCell() }
            guard let userInfo = presenter.getUserInformation() else { return cell }
            cell.setUserInformation(userInfo) { [weak self] in
                self?.presenter.actionChangeName()
            } changePhotoComplition: { [weak self] in
                self?.presenter.actionChangePhoto()
            }
            return cell

        case .profileButtons:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.profileButtonViewCellIdentifire,
                for: indexPath
            ) as? ProfileButtonViewCell else { return UITableViewCell() }

            switch buttons[indexPath.row] {
            case .bonuses:
                cell.setButtonInformation(text: Constants.bonusesButtonText, icon: .starIcon) { [weak self] in
                    self?.showBonuses()
                }
            case .termsAndPrivacy:
                cell.setButtonInformation(text: Constants.termsAndPrivacyButtonText, icon: .sheetIcon) { [weak self] in
                    self?.showTermsAndPrivacy()
                }
            case .logOut:
                cell.setButtonInformation(text: Constants.logOutButtonText, icon: .shareIcon) { [weak self] in
                    self?.showLogOutAllert()
                }
            }
            return cell
        }
    }
}

/// Экшены кнопок
extension ProfileViewController {
    private func showBonuses() {
        presenter.showBonuses()
    }

    private func showTermsAndPrivacy() {
        presenter.termsAndPrivacyAction()
    }

    private func showLogOutAllert() {
        presenter.logOutAction()
    }
}
