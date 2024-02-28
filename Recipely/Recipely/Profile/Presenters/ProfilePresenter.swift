// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана профиля
protocol ProfileViewProtocol: AnyObject {
    func showChangeNameAlert()
    func showInDevelopAlert()
    func showLogOutAlert()
    func setNewNameFromSource()
    func setPhotoFromSource()
}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    var coordinator: ProfileCoordinator? { get set }
    var infoSource: InfoSourceProtocol? { get set }
    init(view: ProfileViewProtocol)
    func getUserInformation() -> UserInfo?
    func logOut()
    func logOutAction()
    func showBonuses()
    func actionChangeName()
    func actionChangePhoto()
    func termsAndPrivacyAction()
    func editNameSurname(name: String)
}

/// Протокол источника информации
protocol InfoSourceProtocol: AnyObject {
    func getUserInfo() -> UserInfo
    func changeUserName(nameSurname: String)
    func getBonusesCount() -> Int
}

/// Презентер экрана профиля
final class ProfilePresenter: ProfileViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: ProfileCoordinator?
    weak var view: ProfileViewProtocol?
    var infoSource: InfoSourceProtocol?

    // MARK: - Initializers

    required init(view: ProfileViewProtocol) {
        self.view = view
    }

    // MARK: - Public Methods

    func getUserInformation() -> UserInfo? {
        infoSource?.getUserInfo()
    }

    func logOutAction() {
        view?.showLogOutAlert()
    }

    func logOut() {
        coordinator?.logOut()
    }

    func showBonuses() {
        coordinator?.showBonuses()
    }

    func actionChangeName() {
        view?.showChangeNameAlert()
    }

    func editNameSurname(name: String) {
        infoSource?.changeUserName(nameSurname: name)
        view?.setNewNameFromSource()
    }

    func termsAndPrivacyAction() {
        view?.showInDevelopAlert()
    }

    // TODO:
    func actionChangePhoto() {}
}
