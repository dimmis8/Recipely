// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана авторизации
protocol AutorizationViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: AutorizationCoordinator? { get set }
    /// Модуль проверки введенных пользоватлем данных
    var autorizationValidation: AutorizationValidationProtocol? { get set }
    /// Инициализатор с присвоением вью
    init(view: AutorizationViewProtocol)
    /// Проверка валидации пароля
    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool?
    /// Функция изменения состояния видимости пароля
    func changePasswordVisableState()
}

/// Презентер экрана авторизации
final class AutorizationPresenter: AutorizationViewPresenterProtocol {
    // MARK: - Public Properties

    var autorizationValidation: AutorizationValidationProtocol?
    weak var coordinator: AutorizationCoordinator?
    weak var view: AutorizationViewProtocol?

    // MARK: - Private Properties

    private var isPasswordVisible = false

    // MARK: - Initializers

    required init(view: AutorizationViewProtocol) {
        self.view = view
    }

    // MARK: - Public method

    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool? {
        autorizationValidation?.isValid(enteringEmail: enteringEmail, enteringPassword: enteringPassword)
    }

    func changePasswordVisableState() {
        isPasswordVisible = !isPasswordVisible
        view?.changePasswordvisableState(isVisable: isPasswordVisible)
    }
}
