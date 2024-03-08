// LoggerInvoker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Инвокер
final class LoggerInvoker {
    // MARK: - Singleton

    static let shared = LoggerInvoker()

    // MARK: - Private properties

    private let logger = Logger()
    private var commands: [LogCommand] = []

    // MARK: - Public Methods

    func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandsIfNeeded()
    }

    // MARK: - Private Methods

    private func executeCommandsIfNeeded() {
        commands.forEach { self.logger.writeMessageToLog($0.logMessage) }
        commands = []
    }
}
