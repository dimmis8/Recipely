// InfoSource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол источника информации
protocol InfoSourceProtocol: AnyObject {
    /// Передача информации о пользователе
    func getUserInfo() -> UserInfo
    /// Изменение имени пользователя
    func changeUserName(nameSurname: String)
    /// Получение информации о количестве бонусов
    func getBonusesCount() -> Int
}

/// Источник информации
final class InfoSource: InfoSourceProtocol {
    // Информация о пользователе
    private var personInfo = UserInfo(nameSurname: "Steve Wozniak", userPhotoName: "voznyak", bonusesCount: 200)

    func getUserInfo() -> UserInfo {
        personInfo
    }

    func changeUserName(nameSurname: String) {
        personInfo.nameSurname = nameSurname
    }

    func getBonusesCount() -> Int {
        personInfo.bonusesCount
    }
}
