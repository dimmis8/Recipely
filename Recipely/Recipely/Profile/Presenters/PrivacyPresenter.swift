// PrivacyPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана информации о приватности
protocol PrivacyPresenterProtocol: AnyObject {
    /// Инициализатор с присвоением вью источника данных
    init(view: PrivacyViewProtocol, coordinator: ProfileCoordinator)
    /// Функция закрытия экрана бонусов
    func close()
}

/// Презентер экрана бонусов
final class PrivacyPresenter: PrivacyPresenterProtocol {
    // MARK: - Private Properties

    private weak var coordinator: ProfileCoordinator?
    private weak var view: PrivacyViewProtocol?

    // MARK: - Initializers

    required init(view: PrivacyViewProtocol, coordinator: ProfileCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Private Methods

    func close() {}
}
