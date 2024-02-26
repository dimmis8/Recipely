// AutorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран входа
final class AutorizationViewController: UIViewController {
    weak var coordinator: AutorizationCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
