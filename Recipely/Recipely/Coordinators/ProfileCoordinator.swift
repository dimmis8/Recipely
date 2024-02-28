// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана профиля
final class ProfileCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var moduleBuilder: Builder
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?
    var dismissBonuses: (() -> ())?

    // MARK: - Initializers

    init(rootController: UIViewController, moduleBulder: Builder) {
        self.rootController = UINavigationController(rootViewController: rootController)
        moduleBuilder = moduleBulder
    }

    // MARK: - Public Methods

    func logOut() {
        onFinishFlow?()
    }

    func showBonuses() {
        let profileBonusesView = moduleBuilder.createBonusesProfileModule()
        profileBonusesView.presenter.coordinator = self
        if let sheet = profileBonusesView.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        dismissBonuses = {
            profileBonusesView.dismiss(animated: true)
        }
        rootController.present(profileBonusesView, animated: true)
    }
}
