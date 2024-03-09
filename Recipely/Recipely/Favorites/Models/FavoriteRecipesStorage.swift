// FavoriteRecipesStorage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Хранилище избранных рецептов
struct FavoriteRecipesStorage {
    // MARK: - Singleton

    static var shared = FavoriteRecipesStorage()

    // MARK: - Public Properties

    @Storage()
    var favoriteRecipes: [Recipe]?

    // MARK: - Initializers

    private init() {
        _favoriteRecipes.key = StorageKeys.favorite.rawValue
    }
}
