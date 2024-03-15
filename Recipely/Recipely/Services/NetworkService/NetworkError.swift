// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ошибки нетворк сервиса
enum NetworkError: Error {
    /// Не удалось преобразовать String в URL
    case notValidURL
    /// Данные не существуют
    case nilData
    /// Ошибка сети
    case networkError(Int)
}
