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
    case decodingError
    case noData
    case customError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"

        case .requestFailed:
            return "Request Failed"

        case .decodingError:
            return "Decoding Error"

        case .customError(let error):
            return error.localizedDescription

        case .noData:
            return "No data received"
        }
    }
}
