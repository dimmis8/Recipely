// StorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис хранения
final class StorageService<T: Codable> {
    // MARK: - Private Properties

    private var keyee: StorageKeys?

    @Storage()
    private var memento: Memento?

    // MARK: - Initializers

    init(key: StorageKeys) {
        _memento.key = key.rawValue
    }

    // MARK: - Public Methods

    func getContent() -> T? {
        memento?.getContent()
    }

    func setContent(_ content: T) {
        memento = Memento(mementoObject: content)
    }
}
