// AutorizationValidation.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  Валидация
class AutorizationValidation: AutorizationValidationProtocol {
    // MARK: - Public method

    func isValid(_ validityType: ValidityType, enteringText: String) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: enteringText)
    }
}

/// Добавление валидации возможных regex
extension AutorizationValidation {
    /// Перечисление символов
    enum Regex: String {
        /// regex для емайла
        case email = "1234"
        /// regex для пароля
        case password = "123"
    }
}
