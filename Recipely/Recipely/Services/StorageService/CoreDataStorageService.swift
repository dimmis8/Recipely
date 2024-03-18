// CoreDataStorageService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Сервис для хранения в CoreData
final class CoreDataStorageService {
    // MARK: - Constants

    enum Constants {
        static let containerName = "CoreDataStorage"
        static let entityName = "StorageRecipesCard"
    }

    static let shared = CoreDataStorageService()

    // MARK: - Private Properties

    private var context: NSManagedObjectContext
    private var persistentContainer: NSPersistentContainer

    // MARK: - Initializers

    private init() {
        persistentContainer = {
            let container = NSPersistentContainer(name: Constants.containerName)
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    print(error)
                }
            }
            return container
        }()
        context = persistentContainer.viewContext
    }

    // MARK: - Public Methods

    func createRecipes(_ recipeCards: [RecipeCard], recipesCategory: String) {
        let storageRecipesCard = StorageRecipesCard(context: context)

        if let storageRecipeCards = getRecipes() {
            if storageRecipeCards.contains(where: { $0.recipesCategory == recipesCategory }) {
                updateRecipes(searchPhrase: recipesCategory, newRecipes: recipeCards)
                return
            }
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipeCards) {
            storageRecipesCard.recipesCard = encoded
            storageRecipesCard.recipesCategory = recipesCategory
            saveContext()
        }
    }

    func createRecipeDetails(_ recipeDetails: RecipeDetails, uri: String) {
        let storageRecipesCard = StorageRecipesCard(context: context)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipeDetails) {
            storageRecipesCard.recipesCard = encoded
            storageRecipesCard.recipesCategory = uri
            saveContext()
        }
    }

    func fetchRecipes(_ category: String) -> [RecipeCard] {
        do {
            let decoder = JSONDecoder()
            guard let storageRecipeCards = getRecipes(),
                  let storageRecipeCard = storageRecipeCards.first(where: { $0.recipesCategory == category })?
                  .recipesCard,
                  let recipeCards = try? decoder.decode([RecipeCard].self, from: storageRecipeCard) else { return [] }
            return recipeCards
        }
    }

    func fetchRecipeDetails(_ uri: String) -> RecipeDetails? {
        do {
            let decoder = JSONDecoder()
            guard let storageRecipeCards = getRecipes(),
                  let storageRecipeCard = storageRecipeCards.first(where: { $0.recipesCategory == uri })?
                  .recipesCard,
                  let recipeCards = try? decoder.decode(RecipeDetails.self, from: storageRecipeCard) else { return nil }
            return recipeCards
        }
    }

    func updateRecipes(searchPhrase: String, newRecipes: [RecipeCard]) {
        guard let storageRecipeCards = getRecipes(),
              let storageRecipeCard = storageRecipeCards.first(where: { $0.recipesCategory == searchPhrase })
        else { return }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newRecipes) {
            storageRecipeCard.recipesCard = encoded
            saveContext()
        }
    }

    func deleteAllRecipes() {
        guard let storageRecipeCards = getRecipes() else { return }
        storageRecipeCards.forEach { context.delete($0) }
        saveContext()
    }

    // MARK: - Private Methods

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
            }
        }
    }

    private func getRecipes() -> [StorageRecipesCard]? {
        try? context
            .fetch(NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)) as? [StorageRecipesCard]
    }
}
