//
//  NetworkManager.swift
//  News
//
//  Created by Mert Ozseven on 12.02.2025.
//

import Foundation

// MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol {
    func request<T: Codable>(
        endpoint: String,
        queryItems: [URLQueryItem],
        method: String,
        headers: [String: String]?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

// MARK: - NetworkManager

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSession
    private let baseURL = "https://newsapi.org/"
    private let apiKey = "773153e605234b7bae3f92a77d65f772"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Codable>(
        endpoint: String,
        queryItems: [URLQueryItem],
        method: String = "GET",
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        var urlComponents = URLComponents(string: baseURL + endpoint)
        urlComponents?.queryItems = queryItems + [URLQueryItem(name: "apiKey", value: apiKey)]

        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
