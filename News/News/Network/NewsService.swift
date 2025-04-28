//
//  NewsService.swift
//  News
//
//  Created by Mert Ozseven on 12.02.2025.
//

import Foundation

// MARK: - NewsServiceProtocol

protocol NewsServiceProtocol {
    func searchNews(
        searchString: String,
        page: Int,
        pageSize: Int,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    )

    func fetchTopNews(
        country: String,
        pageSize: Int,
        page: Int,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    )
}

// MARK: - NewsService

final class NewsService: NewsServiceProtocol {
    private let networkManager: NetworkManagerProtocol
    private let baseURL = "https://newsapi.org/v2/"
    private let apiKey = "2540ed5df6c048d2a49696d55f11c91a"

    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    // MARK: Search News

    func searchNews(
        searchString: String,
        page: Int = 1,
        pageSize: Int = 20,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    ) {
        var urlComponents = URLComponents(string: baseURL + "everything")
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: searchString),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }

        networkManager.request(
            url: url,
            method: .GET,
            headers: nil,
            completion: completion
        )
    }

    // MARK: Fetch Top News

    func fetchTopNews(
        country: String,
        pageSize: Int = 20,
        page: Int = 1,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    ) {
        var urlComponents = URLComponents(string: baseURL + "top-headlines")
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }

        networkManager.request(
            url: url,
            method: .GET,
            headers: nil,
            completion: completion
        )
    }
}
