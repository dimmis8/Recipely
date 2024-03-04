// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор флоу профиля
final class ProfileCoordinator: BaseCoodinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: VoidHandler?
    var dismissBonuses: VoidHandler?

    // MARK: - Private Properties

    private var moduleBuilder: Builder?
    private lazy var privacyView = moduleBuilder?.createPrivacyViewModule(coordinator: self)

    // MARK: - Public Methods

    func setRootViewController(view: UIViewController, moduleBuilder: Builder) {
        rootController = UINavigationController(rootViewController: view)
        self.moduleBuilder = moduleBuilder
    }

    func logOut() {
        onFinishFlow?()
    }

    func showBonuses() {
        let profileBonusesView = moduleBuilder?.createBonusesProfileModule(coordinator: self)
        if let sheet = profileBonusesView?.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 30
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = true
        }
        dismissBonuses = {
            profileBonusesView?.dismiss(animated: true)
        }
        rootController?.present(profileBonusesView ?? UIViewController(), animated: true)
    }

    func openPrivacyInfo() {
        guard let privacyView = privacyView else { return }
        let profileView = rootController?.viewControllers.last?.view
        profileView?.addSubview(privacyView.view)
        privacyView.view.frame = CGRect(
            x: 0,
            y: (profileView?.frame.height ?? 0) - 100,
            width: profileView?.bounds.width ?? 0,
            height: 600
        )
    }
}
