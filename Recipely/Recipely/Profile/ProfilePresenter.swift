// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана профиля
protocol ProfileViewProtocol: AnyObject {
    func setupAlert()
}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    var coordinator: ProfileCoordinator? { get set }
    var infoSource: InfoSourceProtocol? { get set }
    init(view: ProfileViewProtocol)
    func getUserInformation() -> UserInfo?
    func logOut()
    func actionTapped()
    func editNameSurname(name: String)
}

/// Протокол источника информации
protocol InfoSourceProtocol: AnyObject {
    func getUserInfo() -> UserInfo
    func changeUserName(nameSurname: String)
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

    func logOut() {
        coordinator?.logOut()
    }

    func actionTapped() {
        view?.setupAlert()
    }

    func editNameSurname(name: String) {
        infoSource?.changeUserName(nameSurname: name)
    }
}
