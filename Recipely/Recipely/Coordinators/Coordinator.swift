// Coordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол координатора
protocol Coordinator: AnyObject {
    /// Дочерние координаторы
    var childrenCoordinators: [Coordinator] { get set }
    /// Навигейшн-контроллер
    var navigationController: UINavigationController { get set }
    /// Функция запуска координатора
    func start()
}
