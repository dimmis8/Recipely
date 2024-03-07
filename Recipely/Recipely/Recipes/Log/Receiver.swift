// Receiver.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ресивер
final class Logger {
    // MARK: - Private Properties

    private var messages: [String] = []

    // MARK: - Public Methods

    func writeMessageToLog(_ message: String) {
        messages.append(message)
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let logSessionUrl = url[0].appendingPathComponent("LogSession")
        do {
            try manager.createDirectory(at: logSessionUrl, withIntermediateDirectories: true)
        } catch {
            print(error)
        }
        let logFileUrl = logSessionUrl.appendingPathComponent("Log.txt")
        let data = "\(messages)".data(using: .utf8)
        manager.createFile(
            atPath: logFileUrl.path(percentEncoded: true),
            contents: data
        )
        print(message)
    }
}
