// StorageRecipesCard+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Кеш рецептов для категорий
@objc(StorageRecipesCard)
final class StorageRecipesCard: NSManagedObject {}

extension StorageRecipesCard {
    @NSManaged var recipesCard: Data?
    @NSManaged var recipesCategory: String?
}
