// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана профиля
final class ProfileCoordinator: BaseCoodinator {
    private var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logOut() {
        onFinishFlow?()
    }

//    func ​pushProfile() {
//        let profileViewController = ModuleBuilder.createProfileModule()
//        rootController.pushViewController(profileViewController, animated: true)
//    }
}
