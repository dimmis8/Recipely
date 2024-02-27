// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана профиля
protocol ProfileViewProtocol: AnyObject {}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    var coordinator: ProfileCoordinator? { get set }
    var infoSource: InfoSourceProtocol? { get set }
    init(view: ProfileViewProtocol)
    func getUserInformation() -> UserInfo?
    func logOut()
}

/// Протокол источника информации
protocol InfoSourceProtocol: AnyObject {
    func getUserInfo() -> UserInfo
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
}
