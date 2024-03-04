// SourceOfRecepies.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Источник данных для рецептов
struct SourceOfRecepies {
    var fishRecepies: [Recipe] = [
        Recipe(title: "Baked Fish with Lemon Herb Sauce", cookTime: 90, calories: 616, imageName: "backedFish"),
        Recipe(title: "Chilli and Tomato Fish", cookTime: 100, calories: 174, imageName: "chilliAndTomato"),
        Recipe(title: "Fast Roast Fish & Show Peas Recipes", cookTime: 80, calories: 94, imageName: "fastRoast"),
        Recipe(title: "Lemon and Chilli Fish Burrito", cookTime: 90, calories: 226, imageName: "lemonAndChilli"),
        Recipe(title: "Salmon with Cantaloupe and Fried Shallots", cookTime: 100, calories: 410, imageName: "salmon"),
        Recipe(
            title: "Simple Fish And Corn",
            cookTime: 60,
            calories: 274,
            imageName: "simpleFish",
            weight: 793,
            carbohydrates: 10.78,
            fats: 10.00,
            proteins: 97.3,
            description: """
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            1/2 to 2 fish heads, depending on size, about 5 pounds total
            2 tablespoons vegetable oil
            1/4 cup red or green thai curry paste
            3 tablespoons fish sauce or anchovy sauce
            1 tablespoon sugar
            1 can coconut milk, about 12 ounces
            3 medium size asian eggplants, cut int 1 inch rounds
            Handful of bird's eye chilies
            1/2 cup thai basil leaves
            Juice of 3 limes
            """
        ),
    ]

    mutating func getSortedInfo(selectedSortMap: [SortTypes: SortState]) {
        switch (selectedSortMap[.calories], selectedSortMap[.time]) {
        case (.fromMostToLeast, .withoutSort):
            fishRecepies.sort { $0.calories > $1.calories }
        case (.fromLeastToMost, .withoutSort):
            fishRecepies.sort { $0.calories < $1.calories }
        case (.withoutSort, .fromMostToLeast):
            fishRecepies.sort { $0.cookTime > $1.cookTime }
        case (.withoutSort, .fromLeastToMost):
            fishRecepies.sort { $0.cookTime < $1.cookTime }
        case (.withoutSort, .withoutSort):
            fishRecepies.sort { $0.title < $1.title }
        case (.fromMostToLeast, .fromMostToLeast):
            fishRecepies = fishRecepies
                .sorted { $0.cookTime > $1.cookTime }
                .sorted { $0.cookTime == $1.cookTime ? true : $0.calories > $1.calories }
        case (.fromLeastToMost, .fromMostToLeast):
            fishRecepies = fishRecepies
                .sorted { $0.cookTime > $1.cookTime }
                .sorted { $0.cookTime == $1.cookTime ? true : $0.calories < $1.calories }
        case (.fromMostToLeast, .fromLeastToMost):
            fishRecepies = fishRecepies
                .sorted { $0.cookTime < $1.cookTime }
                .sorted { $0.cookTime == $1.cookTime ? true : $0.calories > $1.calories }
        case (.fromLeastToMost, .fromLeastToMost):
            fishRecepies = fishRecepies
                .sorted { $0.cookTime < $1.cookTime }
                .sorted { $0.cookTime == $1.cookTime ? true : $0.calories < $1.calories }
        default:
            break
        }
    }
}
