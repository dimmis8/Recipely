// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью источника данных
    init(view: ProfileViewProtocol, infoSource: InfoSourceProtocol, coordinator: ProfileCoordinator)
    /// Получение информации о пользователе
    func getUserInformation() -> ViewData<UserInfo>
    /// Выход из аккаунта
    func logOut()
    /// Обработка нажатия кнопки Log out
    func logOutAction()
    /// Показ экрана с фонусами
    func showBonuses()
    /// Обработка нажатия кнопки изменения имени
    func actionChangeName()
    /// Изменение имени пользователя
    func editNameSurname(name: String)
    /// Открытие информации о приватности
    func openPrivacyInfo()
}

/// Презентер экрана профиля
final class ProfilePresenter: ProfileViewPresenterProtocol {
    // MARK: - Public Properties

    private weak var coordinator: ProfileCoordinator?
    private weak var view: ProfileViewProtocol?
    private var infoSource: InfoSourceProtocol?
    private var isFirstRequest = true
    private var stateOfLoading: ViewData<UserInfo>

    // MARK: - Initializers

    required init(view: ProfileViewProtocol, infoSource: InfoSourceProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        self.infoSource = infoSource
        self.coordinator = coordinator
        stateOfLoading = .initial
    }

    // MARK: - Public Methods

    func getUserInformation() -> ViewData<UserInfo> {
        if isFirstRequest {
            stateOfLoading = .loading(nil)
            Timer.scheduledTimer(
                timeInterval: 3,
                target: self,
                selector: #selector(setInfo),
                userInfo: nil,
                repeats: false
            )
        }
        return stateOfLoading
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

    func openPrivacyInfo() {
        view?.showPrivacyCard(privacyText: infoSource?.privacyText ?? "error")
    }

    // MARK: - Private Methods

    @objc private func setInfo() {
        isFirstRequest = false
        stateOfLoading = .succes(infoSource?.getUserInfo())
        view?.reloadTableView()
    }
}
