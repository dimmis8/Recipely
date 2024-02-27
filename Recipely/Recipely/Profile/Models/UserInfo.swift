// UserInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Информация о пользователе
struct UserInfo {
    /// Имя и фамилия пользователя
    var nameSurname: String
    /// Название фото пользователя
    var userPhotoName: String

    init(nameSurname: String, userPhotoName: String = "userDefaultIcon") {
        self.nameSurname = nameSurname
        self.userPhotoName = userPhotoName
    }
}
