// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        createRootViewController(windowScene)
        Logger.logFileDate = Date()
    }

    private func createRootViewController(_ windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        if let window {
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator(appBuilder: ModuleBuilder())
            appCoordinator?.start()
        }
    }
}
