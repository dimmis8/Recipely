// LogCommand.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Комманд
final class LogCommand {
    // MARK: - Public Propeties

    var logMessage: String {
        switch action {
        case .openRecipe:
            "Пользователь открыл “Экран рецептов”"
        case .openCatagoryOfRecipe:
            "Пользовать перешел на ”Экран со списком рецептов из Рыбы”"
        case .openDetailsRecipe:
            "Пользователь открыл ”Детали рецепта”"
        case .tapShareButton:
            "Пользователь поделился рецептом"
        case .openFavorites:
            "Пользователь открыл экран избранного"
        case .openProfile:
            "Пользователь открыл экран пользователя"
        case .openPrivacy:
            "Пользователь открыл экран политики конфидециальности"
        case .openBonuses:
            "Пользователь открыл экран бонусов"
        case .openImagePicker:
            "Пользователь открыл экран смены фото"
        case .openChangeNameAlert:
            "Пользователь открыл форма изменения имени"
        case .openAutorization:
            "Пользователь открыл экран авторизации"
        }
    }

    // MARK: - Private Methods

    private let action: LogActions

    // MARK: - Initializers

    init(action: LogActions) {
        self.action = action
    }
}
