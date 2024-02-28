// ProfileBonusesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана бонусов
protocol ProfileBonusesViewProtocol: AnyObject {
    func setBonuses(bonusesCount: Int)
}

/// Протокол презентера экрана бонусов
protocol ProfileBonusesViewPresenterProtocol: AnyObject {
    var infoSource: InfoSourceProtocol { get set }
    var coordinator: ProfileCoordinator? { get set }
    init(view: ProfileBonusesViewProtocol, infoSource: InfoSourceProtocol)
    func dismissSelf()
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

    func dismissSelf() {
        coordinator?.dismissBonuses?()
    }
}
