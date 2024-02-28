// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: ProfileCoordinator? { get set }
    /// Источник данных
    var infoSource: InfoSourceProtocol? { get set }
    /// Инициализатор с присвоением вью источника данных
    init(view: ProfileViewProtocol, infoSource: InfoSourceProtocol)
    /// Получение информации о пользователе
    func getUserInformation() -> UserInfo?
    /// Выход из аккаунта
    func logOut()
    /// Обработка нажатия кнопки Log out
    func logOutAction()
    /// Показ экрана с фонусами
    func showBonuses()
    /// Обработка нажатия кнопки изменения имени
    func actionChangeName()
    /// Обработка нажатия кнопки изменения фото
    func actionChangePhoto()
    /// Обработка нажатия кнопки Terms And Privacy
    func termsAndPrivacyAction()
    /// Изменение имени пользователя
    func editNameSurname(name: String)
}

/// Презентер экрана профиля
final class ProfilePresenter: ProfileViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: ProfileCoordinator?
    weak var view: ProfileViewProtocol?
    var infoSource: InfoSourceProtocol?

    // MARK: - Initializers

    required init(view: ProfileViewProtocol, infoSource: InfoSourceProtocol) {
        self.view = view
        self.infoSource = infoSource
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
