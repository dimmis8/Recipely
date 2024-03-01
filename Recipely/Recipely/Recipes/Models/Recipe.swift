// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Рецепт
struct Recipe {
    /// Название рецепта
    var title: String
    /// Время на приготовление
    var cookTime: Int
    /// Калории
    var calories: Int
    /// Картинка
    var imageName: String

    init(title: String = "", cookTime: Int = 0, calories: Int = 0, imageName: String = "") {
        self.title = title
        self.cookTime = cookTime
        self.calories = calories
        self.imageName = imageName
    }
}
