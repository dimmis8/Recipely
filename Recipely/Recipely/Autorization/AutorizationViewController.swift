// AutorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class AutorizationViewController: UIViewController {
    // MARK: - Public Properties

    weak var coordinator: AutorizationCoordinator?
    var presenter: AutorizationViewPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

/// Подписание на протокол экрана авторизации
extension AutorizationViewController: AutorizationViewProtocol {}
