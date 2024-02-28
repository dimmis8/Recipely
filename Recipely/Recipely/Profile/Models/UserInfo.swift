// UserInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о пользователе
struct UserInfo {
    /// Имя и фамилия пользователя
    var nameSurname: String
    /// Название фото пользователя
    var userPhotoName: String
    /// Количество бонусов
    var bonusesCount: Int

    init(nameSurname: String, userPhotoName: String = "userDefaultIcon", bonusesCount: Int) {
        self.nameSurname = nameSurname
        self.userPhotoName = userPhotoName
        self.bonusesCount = bonusesCount
    }
}
