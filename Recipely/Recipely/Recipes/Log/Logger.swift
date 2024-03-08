// Logger.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ресивер
final class Logger {
    // MARK: - Public Properties

    static var logFileDate = Date()

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
        } catch {}
        let logFileUrl = logSessionUrl.appendingPathComponent("Log_\(Logger.logFileDate).txt")
        print(logSessionUrl)
        var logsText = ""
        for log in messages {
            logsText.append("\(Date()) : \(log) \n")
        }
        let data = logsText.data(using: .utf8)
        manager.createFile(
            atPath: logFileUrl.path(percentEncoded: true),
            contents: data
        )
    }

    func saveScreenshot(_ screenshotData: Data) {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask)
        let screenshotsSessionUrl = url[0].appendingPathComponent("LogSession").appendingPathComponent("Screenshots")
        do {
            try manager.createDirectory(at: screenshotsSessionUrl, withIntermediateDirectories: true)
        } catch {}
        let screenFileUrl = screenshotsSessionUrl.appendingPathComponent("Screenshot_\(Date()).png")
        manager.createFile(
            atPath: screenFileUrl.path(percentEncoded: true),
            contents: screenshotData
        )
    }
}
