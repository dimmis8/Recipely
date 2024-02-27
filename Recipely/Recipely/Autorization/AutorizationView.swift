// AutorizationView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class AutorizationViewController: UIViewController {
    // MARK: - Public Properties

    var presenter: AutorizationViewPresenterProtocol!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

// MARK: - Подписание на протокол экрана авторизации

extension AutorizationViewController: AutorizationViewProtocol {}
