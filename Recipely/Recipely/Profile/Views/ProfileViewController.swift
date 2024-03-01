// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол экрана профиля
protocol ProfileViewProtocol: AnyObject {
    ///  Презентер экрана
    var presenter: ProfileViewPresenterProtocol? { get set }
    /// Показ алерта с полем для измененеия имени
    func showChangeNameAlert()
    /// Показ алерта с сообщением о разработки функциональности
    func showInDevelopAlert()
    /// Показ алерта с сообщением о подтверждении выхода с аккаунта
    func showLogOutAlert()
    /// Установка нового имени из источника данных
    func setNewNameFromSource()
    /// Установка нового фото из источника данных
    func setPhotoFromSource()
}

/// Экран профиля
final class ProfileViewController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let viewTitleText = "Profile"
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

    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.viewTitleText
        label.font = .verdanaBold(ofSize: 28)
        return label
    }()

    private let tableView = UITableView()

    // MARK: - Public Properties

    var presenter: ProfileViewPresenterProtocol?

    // MARK: - Private Properties

    private let contentTypes: [ContentTypes] = [.userInfo, .profileButtons]
    private let fields: [FieldsType] = [.bonuses, .termsAndPrivacy, .logOut]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }

    // MARK: - Private Methods

    private func configureView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileLabel)
    }

    private func setNewName(_ newName: String) {
        presenter?.editNameSurname(name: newName)
    }

    private func configureTableView() {
        tableView.register(UserInfoViewCell.self, forCellReuseIdentifier: UserInfoViewCell.identifier)
        tableView.register(
            ProfileFieldsViewCell.self,
            forCellReuseIdentifier: ProfileFieldsViewCell.identifier
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

    private func showBonuses() {
        presenter?.showBonuses()
    }

    private func showTermsAndPrivacy() {
        presenter?.termsAndPrivacyAction()
    }

    private func showLogOutAllert() {
        presenter?.logOutAction()
    }

    func showAlert(title: String, buttonAgreeTitle: String, handler: VoidHandler?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionClose = UIAlertAction(title: Constants.closeButtonText, style: .default)
        let actionYes = UIAlertAction(title: buttonAgreeTitle, style: .default) { _ in
            handler?()
        }
        alertController.addAction(actionClose)
        alertController.addAction(actionYes)
        present(alertController, animated: true)
    }
}

// MARK: - ProfileViewController + ProfileViewProtocol

extension ProfileViewController: ProfileViewProtocol {
    func showLogOutAlert() {
        showAlert(title: Constants.alertTitle, buttonAgreeTitle: Constants.yesButtonText) { [weak self] in
            self?.presenter?.logOut()
        }
    }

    func showChangeNameAlert() {
        let alertView = UIAlertController(title: Constants.alertText, message: nil, preferredStyle: .alert)
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
        showAlert(title: Constants.termsAndPrivacyAlertMassage, buttonAgreeTitle: Constants.okButtonText, handler: nil)
    }

    // TODO:
    func setPhotoFromSource() {}

    func setNewNameFromSource() {
        tableView.reloadData()
    }
}

// MARK: - Добавление групп контента и вида кнопок на экране профиля

extension ProfileViewController {
    enum ContentTypes {
        /// Информация о пользователе
        case userInfo
        /// Кнопки с дополнительными возможностями
        case profileButtons
    }

    enum FieldsType {
        /// Кнопка бонусов
        case bonuses
        /// Кнопка условия эксплуатации
        case termsAndPrivacy
        /// Кнопка выхода
        case logOut
    }
}

// MARK: - ProfileViewController + UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        contentTypes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentTypes[section] {
        case .userInfo:
            return 1
        case .profileButtons:
            return fields.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contentTypes[indexPath.section] {
        case .userInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserInfoViewCell.identifier,
                for: indexPath
            ) as? UserInfoViewCell, let userInfo = presenter?.getUserInformation() else { return UITableViewCell() }
            cell.setUserInformation(userInfo) { [weak self] in
                self?.presenter?.actionChangeName()
            } changePhotoComplition: { [weak self] in
                self?.presenter?.actionChangePhoto()
            }

            return cell

        case .profileButtons:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileFieldsViewCell.identifier,
                for: indexPath
            ) as? ProfileFieldsViewCell else { return UITableViewCell() }

            switch fields[indexPath.row] {
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
