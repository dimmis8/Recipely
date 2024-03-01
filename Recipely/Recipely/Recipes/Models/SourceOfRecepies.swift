// SourceOfRecepies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник данных для рецептов
struct SourceOfRecepies {
    let fishRecepies: [Recipe] = [
        Recipe(title: "Simple Fish And Corn", cookTime: 60, calories: 274, imageName: "simpleFish"),
        Recipe(title: "Baked Fish with Lemon Herb Sauce", cookTime: 90, calories: 616, imageName: "backedFish"),
        Recipe(title: "Lemon and Chilli Fish Burrito", cookTime: 90, calories: 226, imageName: "lemonAndChilli"),
        Recipe(title: "Fast Roast Fish & Show Peas Recipes", cookTime: 80, calories: 94, imageName: "fastRoast"),
        Recipe(title: "Salmon with Cantaloupe and Fried Shallots", cookTime: 100, calories: 410, imageName: "salmon"),
        Recipe(title: "Chilli and Tomato Fish", cookTime: 100, calories: 174, imageName: "chilliAndTomato")
    ]
}
