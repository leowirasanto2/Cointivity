//
//  DummyJsonService.swift
//  Cointivity
//
//  Created by Leo Wirasanto Laia on 25/04/24.
//

import Foundation

protocol DummyJsonService {
    func get<T: Codable>(_ fileName: String) async throws -> T
}

class DummyJsonImplementation: DummyJsonService {
    
    func get<T: Codable>(_ fileName: String) async throws -> T {
        let responseData = try await data(fileName)
        return try JSONDecoder().decode(T.self, from: responseData)
    }
    
    private func data(_ fileName: String) async throws -> Data  {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        guard let dataURL = url else {
            throw NetworkError.badRequest
        }
        return try Data(contentsOf: dataURL)
    }
}
