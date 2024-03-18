// CacheProxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Network

/// Прокси для кеширования файлов
final class CacheProxy: NetworkServiceProtocol {
    // MARK: - Constants

    enum Constants {
        static let imageCacheFolderName = "ImageCache"
        static let queueLabel = "Monitor"
    }

    // MARK: - Private Properties

    private let networkService: NetworkServiceProtocol
    private let fileManager = FileManager.default
    private var cacheImageFolderURL: URL?
    private let monitor = NWPathMonitor()

    // MARK: - Initializers

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        setupFileManager()
    }

    // MARK: - Public Methods

    func getRecipes(
        category: RecipeCategories,
        search: String?,
        complitionHandler: @escaping (Result<[RecipeCard], Error>) -> ()
    ) {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                self.networkService.getRecipes(category: category, search: search) { result in
                    complitionHandler(result)
                    if case let .success(recipes) = result {
                        CoreDataStorageService.shared.createRecipes(recipes, recipesCategory: category.rawValue)
                    }
                }
            } else {
                complitionHandler(.success(CoreDataStorageService.shared.fetchRecipes(category.rawValue)))
            }
        }
        let queue = DispatchQueue(label: Constants.queueLabel)
        monitor.start(queue: queue)
    }

    func getDetail(uri: String?, complitionHandler: @escaping (Result<RecipeDetails, Error>) -> ()) {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let uri = uri, let self = self else { return }
            if path.status == .satisfied {
                self.networkService.getDetail(uri: uri) { result in
                    complitionHandler(result)
                    if case let .success(recipeDetails) = result {
                        CoreDataStorageService.shared.createRecipeDetails(recipeDetails, uri: uri)
                    }
                }
            } else {
                if let details = CoreDataStorageService.shared.fetchRecipeDetails(uri) {
                    complitionHandler(.success(details))
                } else {
                    complitionHandler(.failure(NetworkError.nilData))
                }
            }
        }
        let queue = DispatchQueue(label: Constants.queueLabel)
        monitor.start(queue: queue)
    }

    func getImageData(stringURL: String, complitionHandler: @escaping (Result<Data, Error>) -> ()) {
        guard let imageNetworkURL = URL(string: stringURL),
              let cacheImageFolderURL = cacheImageFolderURL else { return }

        let imageName = imageNetworkURL.lastPathComponent
        let imageFilePath = cacheImageFolderURL.appendingPathComponent(imageName).path()
        if fileManager.fileExists(atPath: imageFilePath) {
            guard let imageData = fileManager.contents(atPath: imageFilePath) else { return }
            complitionHandler(.success(imageData))
        } else {
            networkService.getImageData(stringURL: stringURL) { [weak self] result in
                switch result {
                case let .success(imageData):
                    self?.fileManager.createFile(atPath: imageFilePath, contents: imageData)
                    complitionHandler(.success(imageData))
                case let .failure(error):
                    complitionHandler(.failure(error))
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setupFileManager() {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        cacheImageFolderURL = url.appendingPathComponent(Constants.imageCacheFolderName)
        guard let cacheImageFolderURL = cacheImageFolderURL,
              !fileManager.fileExists(atPath: cacheImageFolderURL.path()) else { return }
        do {
            try fileManager.createDirectory(at: cacheImageFolderURL, withIntermediateDirectories: true)
        } catch { return }
    }
}
