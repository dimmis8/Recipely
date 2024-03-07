// Command.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Комманд
final class LogCommand {
    private let action: LogActions

    init(action: LogActions) {
        self.action = action
    }

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
        }
    }
}
