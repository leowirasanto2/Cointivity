//
//  NetworkError.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 17/04/24.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError(Error)
    case invalidResponse
    case invalidUrl
    case httpError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            NSLocalizedString("Unable to perform request", comment: "badRequestError")
        case .serverError(let errorMessage):
            NSLocalizedString(errorMessage, comment: "serverError")
        case .decodingError(_):
            NSLocalizedString("Unable to decode", comment: "decodingError")
        case .invalidResponse:
            NSLocalizedString("Invalid response", comment: "invalidResponse")
        case .invalidUrl:
            NSLocalizedString("Invalid URL", comment: "invalidURL")
        case .httpError(_):
            NSLocalizedString("Bad request", comment: "badRequest")
        }
    }
}
