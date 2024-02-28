// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу профиля
final class ProfileCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var moduleBuilder: Builder
    var rootController: UINavigationController
    var onFinishFlow: VoidHandler?
    var dismissBonuses: VoidHandler?

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
        (profileBonusesView as? ProfileBonusesViewProtocol)?.presenter?.coordinator = self
        rootController.present(profileBonusesView, animated: true)
    }
}
