// InfoSource.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник информации
final class InfoSource: InfoSourceProtocol {
    /// Информация о пользователе
    private var personInfo = UserInfo(nameSurname: "Steve Wozniak", userPhotoName: "voznyak", bonusesCount: 200)

    /// Получить информацию о пользователе
    func getUserInfo() -> UserInfo {
        personInfo
    }

    /// Поменять информацию о пользователе
    func changeUserName(nameSurname: String) {
        personInfo.nameSurname = nameSurname
    }

    /// Получить информацию о количестве бонусов
    func getBonusesCount() -> Int {
        personInfo.bonusesCount
    }
}
