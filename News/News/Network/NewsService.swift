//
//  NewsService.swift
//  News
//
//  Created by Mert Ozseven on 12.02.2025.
//

import Foundation

// MARK: - NewsServiceProtocol

protocol NewsServiceProtocol {
    func fetchNews(
        searchString: String,
        page: Int,
        pageSize: Int,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    )
}

// MARK: - NewsService

final class NewsService: NewsServiceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchNews(
        searchString: String,
        page: Int = 1,
        pageSize: Int = 100,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    ) {
        let queryItems = [
            URLQueryItem(name: "q", value: searchString),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]

        networkManager.request(
            endpoint: "v2/everything",
            queryItems: queryItems,
            method: "GET",
            headers: nil,
            completion: completion
        )
    }
}
