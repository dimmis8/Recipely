// ProfileBonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана бонусов
protocol ProfileBonusesViewPresenterProtocol: AnyObject {
    /// Источник данных
    var infoSource: InfoSourceProtocol { get set }
    /// Координатор флоу экрана
    var coordinator: ProfileCoordinator? { get set }
    /// Инициализатор с присвоением вью источника данных
    init(view: ProfileBonusesViewProtocol, infoSource: InfoSourceProtocol)
    /// Функция закрытия экрана бонусов
    func close()
}

/// Презентер экрана бонусов
final class ProfileBonusesPresenter: ProfileBonusesViewPresenterProtocol {
    // MARK: - Public Properties

    weak var coordinator: ProfileCoordinator?
    weak var view: ProfileBonusesViewProtocol?
    var infoSource: InfoSourceProtocol

    // MARK: - Initializers

    required init(view: ProfileBonusesViewProtocol, infoSource: InfoSourceProtocol) {
        self.view = view
        self.infoSource = infoSource
        setBonusesCount()
    }

    // MARK: - Private Methods

    private func setBonusesCount() {
        view?.setBonuses(bonusesCount: infoSource.getBonusesCount())
    }

    func close() {
        coordinator?.dismissBonuses?()
    }
}
