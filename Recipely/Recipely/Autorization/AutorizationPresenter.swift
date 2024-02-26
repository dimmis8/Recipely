// AutorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана авторизации
protocol AutorizationViewProtocol: AnyObject {}

/// Протокол презентера экрана авторизации
protocol AutorizationViewPresenterProtocol: AnyObject {
    init(view: AutorizationViewProtocol)
}

/// Презентер экрана авторизации
final class AutorizationPresenter: AutorizationViewPresenterProtocol {
    // MARK: - Public Properties

    weak var view: AutorizationViewProtocol?

    // MARK: - Initializers

    required init(view: AutorizationViewProtocol) {
        self.view = view
    }
}
