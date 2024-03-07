// LoggerManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Функция для вызова добавления в Лог
protocol LoggerManagerProtocol {
    func log(_ action: LogActions)
}

/// Логер Менеджер
class LoggerManager: LoggerManagerProtocol {
    func log(_ action: LogActions) {
        let command = LogCommand(action: action)
        LoggerInvoker.shared.addLogCommand(command)
    }
}
