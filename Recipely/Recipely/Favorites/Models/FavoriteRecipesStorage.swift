// FavoriteRecipesStorage.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Хранилище избранных рецептов
struct FavoriteRecipesStorage {
    // MARK: - Public Properties

    var favoriteRecipes: [Recipe] = {
        var favoriteRecipes: [Recipe] = []
//        for recipe in SourceOfRecepies().fishRecepies where favoriteRecipes.count < 3 {
//            favoriteRecipes.append(recipe)
//        }
        favoriteRecipes = SourceOfRecepies().favoriteRecipes
        return favoriteRecipes
    }()
}
