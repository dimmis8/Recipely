// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public Properties

    var window: UIWindow?

    // MARK: - Private Properties

    private var appCoordinator: AppCoordinator?

    // MARK: - Public Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createRootViewController(windowScene)
    }

    // MARK: - Private Methods

    private func createRootViewController(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator(appBuilder: ModuleBuilder())
            appCoordinator?.start()
        }
    }
}
