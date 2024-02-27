// AutorizationValidation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Валидация
final class AutorizationValidation: AutorizationValidationProtocol {
    // MARK: - Constants

    enum Constants {
        static let regexForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }

    // MARK: - Private Properties

    private let accounts = ["123@mm.mm": "123"]

    // MARK: - Public method

    func isValid(enteringEmail: String?, enteringPassword: String?) -> Bool {
        let format = "SELF MATCHES %@"
        switch (enteringEmail, enteringPassword) {
        case (.some(let email), nil):
            return NSPredicate(format: format, Constants.regexForEmail).evaluate(with: email) && accounts.keys
                .contains(email)
        case let (.some(email), .some(password)):
            return NSPredicate(format: format, Constants.regexForEmail).evaluate(with: email) && accounts.keys
                .contains(email) && accounts[email] == password
        default:
            return false
        }
    }
}
