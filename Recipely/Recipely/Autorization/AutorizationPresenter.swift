// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана авторизации
protocol AutorizationViewProtocol: AnyObject {
    func changePasswordvisableState(isVisable: Bool)
}

/// Протокол валидации авторизации
protocol AutorizationValidationProtocol: AnyObject {
    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool
}

/// Протокол презентера экрана авторизации
protocol AutorizationViewPresenterProtocol: AnyObject {
    var coordinator: AutorizationCoordinator? { get set }
    var autorizationValidation: AutorizationValidationProtocol? { get set }
    init(view: AutorizationViewProtocol)
    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool?
    func changePasswordVisableState()
}

/// Презентер экрана авторизации
final class AutorizationPresenter: AutorizationViewPresenterProtocol {
    // MARK: - Public Properties

    var autorizationValidation: AutorizationValidationProtocol?
    weak var coordinator: AutorizationCoordinator?
    weak var view: AutorizationViewProtocol?

    // MARK: - Private Properties

    private var isPasswordVisable = false

    // MARK: - Initializers

    required init(view: AutorizationViewProtocol) {
        self.view = view
    }

    // MARK: - Public method

    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool? {
        autorizationValidation?.isValid(enteringEmail: enteringEmail, enteringPassword: enteringPassword)
    }

    func changePasswordVisableState() {
        isPasswordVisable = !isPasswordVisable
        view?.changePasswordvisableState(isVisable: isPasswordVisable)
    }
}
