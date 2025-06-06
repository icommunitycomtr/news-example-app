//
//  NetworkError.swift
//  News
//
//  Created by Mert Ozseven on 12.02.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case requestFailed
    case requestFailedWithStatusCode(Int)
    case decodingError
    case noData
    case customError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request. Please check your endpoint or parameters."

        case .requestFailed:
            return "Request Failed. Please try again later."

        case .requestFailedWithStatusCode(let code):
            return "Request failed with status code: \(code)."

        case .decodingError:
            return "Failed to decode response data."

        case .noData:
            return "No data received from the server."

        case .customError(let error):
            return "An error occurred: \(error.localizedDescription)"
        }
    }
}
