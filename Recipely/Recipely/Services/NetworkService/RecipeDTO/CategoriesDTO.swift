// CategoriesDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO категории рецептов
struct CategoriesDTO: Codable {
    /// Массив рецептов
    let hits: [HitDTO]?
}
