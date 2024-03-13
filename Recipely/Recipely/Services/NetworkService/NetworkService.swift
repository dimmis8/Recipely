// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол Нетворк сервиса
protocol NetworkServiceProtocol {
    /// Функция получения массива карточек рецептов категории
    func getRecipes(
        category: RecipeCategories,
        search: String?,
        complitionHandler: @escaping (Result<[RecipeCard]?, Error>) -> ()
    )
    /// Функция получения деталей рецепта
    func getDetail(uri: String?, complitionHandler: @escaping (Result<RecipeDetails?, Error>) -> ())
    /// Функция получения данных изображения
    func getImageData(url: URL?, complitionHandler: @escaping (Result<Data, Error>) -> ())
}

/// Нетворк сервис
final class NetworkService: NetworkServiceProtocol {
    // MARK: - Constants

    enum Constants {
        static let componentScheme = "https"
        static let componentHost = "api.edamam.com"
        static let componentPathForUri = "/api/recipes/v2/by-uri"
        static let componentPathForRecipes = "/api/recipes/v2"
        static let typeKey = "type"
        static let typeValue = "public"
        static let appIDKey = "app_id"
        static let appIDValue = "cb6e649e"
        static let appKeyKey = "app_key"
        static let appKeyValue = "a94eeec395a193965d15231ec082bd1f"
        static let uriKey = "uri"
        static let dishTypeKey = "dishType"
        static let qKey = "q"
        static let healthKey = "health"
    }

    // MARK: - Public Methods

    func getRecipes(
        category: RecipeCategories,
        search: String?,
        complitionHandler: @escaping (Result<[RecipeCard]?, Error>) -> ()
    ) {
        guard let url = setupURL(category: category, search: search) else {
            complitionHandler(.failure(NetworkError.notValidURL))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                complitionHandler(.failure(error))
                return
            }

            do {
                let parsedData = try JSONDecoder().decode(CategoriesDTO.self, from: data ?? Data())
                guard let hits = parsedData.hits else {
                    complitionHandler(.failure(NetworkError.nilData))
                    return
                }
                var recipes: [RecipeCard] = []

                for hitDTO in hits {
                    guard let recipeDTO = hitDTO.recipe, let recipe = RecipeCard(dto: recipeDTO) else {
                        complitionHandler(.failure(NetworkError.nilData))
                        return
                    }
                    recipes.append(recipe)
                }
                complitionHandler(.success(recipes))
            } catch {
                complitionHandler(.failure(error))
                return
            }
        }.resume()
    }

    func getDetail(uri: String?, complitionHandler: @escaping (Result<RecipeDetails?, Error>) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.componentScheme
        urlComponents.host = Constants.componentHost
        urlComponents.path = Constants.componentPathForUri
        let queryItemType = URLQueryItem(name: Constants.typeKey, value: Constants.typeValue)
        let queryItemAppID = URLQueryItem(name: Constants.appIDKey, value: Constants.appIDValue)
        let queryItemAppKey = URLQueryItem(name: Constants.appKeyKey, value: Constants.appKeyValue)
        let queryItemURI = URLQueryItem(name: Constants.uriKey, value: uri)

        urlComponents.queryItems = [queryItemType, queryItemAppID, queryItemAppKey, queryItemURI]

        guard let url = urlComponents.url else {
            complitionHandler(.failure(NetworkError.notValidURL))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                complitionHandler(.failure(error))
                return
            }

            do {
                let parsedData = try JSONDecoder().decode(CategoriesDTO.self, from: data ?? Data())
                guard let recipeDTO = parsedData.hits?.first?.recipe, let recipeDetails = RecipeDetails(dto: recipeDTO)
                else {
                    complitionHandler(.failure(NetworkError.nilData))
                    return
                }
                complitionHandler(.success(recipeDetails))
            } catch {
                complitionHandler(.failure(error))
                return
            }
        }.resume()
    }

    func getImageData(url: URL?, complitionHandler: @escaping (Result<Data, Error>) -> ()) {
        guard let url = url else {
            complitionHandler(.failure(NetworkError.notValidURL))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in

            if let error = error {
                complitionHandler(.failure(error))
                return
            }

            do {
                let parsedData = try JSONDecoder().decode(Data.self, from: data ?? Data())
                complitionHandler(.success(parsedData))
            } catch {
                complitionHandler(.failure(error))
                return
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func setupURL(category: RecipeCategories, search: String?) -> URL? {
        var dishType = ""
        var qKey = ""
        var health: String?

        switch category {
        case .salad:
            dishType = "Salad"
        case .soup:
            dishType = "Soup"
        case .chicken:
            dishType = "Main course"
            qKey = "Chicken"
        case .meat:
            dishType = "Main course"
            qKey = "Meat"
        case .fish:
            dishType = "Main course"
            qKey = "Fish"
        case .sideDish:
            dishType = "Main course"
            health = "Vegetarian"
        case .drinks:
            dishType = "Drinks"
        case .pancake:
            dishType = "Pancake"
        case .desserts:
            dishType = "Desserts"
        }

        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.componentScheme
        urlComponents.host = Constants.componentHost
        urlComponents.path = Constants.componentPathForRecipes
        let queryItemType = URLQueryItem(name: Constants.typeKey, value: Constants.typeValue)
        let queryItemAppID = URLQueryItem(name: Constants.appIDKey, value: Constants.appIDValue)
        let queryItemAppKey = URLQueryItem(name: Constants.appKeyKey, value: Constants.appKeyValue)
        let queryItemDishType = URLQueryItem(name: Constants.dishTypeKey, value: dishType)

        urlComponents.queryItems = [queryItemType, queryItemAppID, queryItemAppKey, queryItemDishType]

        if let search = search {
            qKey += " \(search)"
        }

        let queryItemQ = URLQueryItem(name: Constants.qKey, value: qKey)
        urlComponents.queryItems?.append(queryItemQ)

        if let health = health {
            let queryItemHealth = URLQueryItem(name: Constants.healthKey, value: health)
            urlComponents.queryItems?.append(queryItemHealth)
        }
        return urlComponents.url
    }
}
