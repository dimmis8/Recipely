// AutorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Авторизационный координатор приложения
final class AutorizationCoordinator: BaseCoodinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }

    func logIn() {
        onFinishFlow?()
    }
}
