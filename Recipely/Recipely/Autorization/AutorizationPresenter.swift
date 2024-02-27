// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана авторизации
protocol AutorizationViewProtocol: AnyObject {}

/// Протокол валидации авторизации
protocol AutorizationValidationProtocol: AnyObject {
    func isValid(_ validityType: ValidityType, enteringText: String) -> Bool
}

/// Протокол презентера экрана авторизации
protocol AutorizationViewPresenterProtocol: AnyObject {
    var coordinator: AutorizationCoordinator? { get set }
    var autorizationValidation: AutorizationValidationProtocol? { get set }
    init(view: AutorizationViewProtocol)
    func checkValid(_ validityType: ValidityType, enteringText: String) -> Bool?
}

/// Презентер экрана авторизации
final class AutorizationPresenter: AutorizationViewPresenterProtocol {
    // MARK: - Public Properties

    var autorizationValidation: AutorizationValidationProtocol?
    weak var coordinator: AutorizationCoordinator?
    weak var view: AutorizationViewProtocol?

    // MARK: - Initializers

    required init(view: AutorizationViewProtocol) {
        self.view = view
    }

    // MARK: - Public method

    func checkValid(_ validityType: ValidityType, enteringText: String) -> Bool? {
        autorizationValidation?.isValid(validityType, enteringText: enteringText)
    }
}
