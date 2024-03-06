// FavoriteRecipesStorage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Хранилище избранных рецептов
struct FavoriteRecipesStorage {
    // MARK: - Public Properties

    var favoriteRecipes: [Recipe] = {
        var favoriteRecipes: [Recipe] = []
        favoriteRecipes = SourceOfRecepies().favoriteRecipes
        return favoriteRecipes
    }()
}
