// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана профиля
protocol ProfileViewProtocol: AnyObject {}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    var coordinator: ProfileCoordinator? { get set }
    init(view: ProfileViewProtocol)
}

/// Презентер экрана профиля
final class ProfilePresenter: ProfileViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: ProfileCoordinator?
    weak var view: ProfileViewProtocol?

    // MARK: - Initializers

    required init(view: ProfileViewProtocol) {
        self.view = view
    }
}
