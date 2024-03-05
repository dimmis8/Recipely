// viewData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Состояния данных
enum ViewData<T> {
    /// Инициализация
    case initial
    /// Загрузка
    case loading(T)
    /// Данные получены
    case succes(T)
    /// Ошибка
    case failure(T)
}
