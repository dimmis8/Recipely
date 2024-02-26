// TabBarPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол экрана с таб баром
protocol TabBarViewProtocol: AnyObject {}

/// Протокол презентера экрана c таб баром
protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarController)
}

/// Презентер экрана с таб баром
final class TabBarPresenter: TabBarViewPresenterProtocol {
    // MARK: - Public Properties

    weak var view: TabBarController?

    // MARK: - Initializers

    required init(view: TabBarController) {
        self.view = view
    }
}
