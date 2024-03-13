// RecipeCard.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Карточка рецепта
struct RecipeCard {
    /// Название рецепта
    let label: String
    /// Ссылка на картинку
    let image: String
    /// Время приготовления
    let totalTime: String
    /// Калорийность
    let calories: String

    init?(dto: RecipeDTO) {
        guard let label = dto.label,
              let image = dto.image,
              let totalTime = dto.totalTime,
              let calories = dto.calories
        else { return nil }

        self.label = label
        self.image = image
        self.totalTime = "\(totalTime.rounded()) min"
        self.calories = "\(calories.rounded()) kkal"
    }
}
