//
//  StaticJSONDecoder.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 21.08.2023.
//

import Foundation

struct StaticJSONDecoder {
    
    static func loadURLAndDecode<T: Decodable>(with finalURL: String) async throws -> T {
        guard let url = URL(string: finalURL) else { throw MovieError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MovieError.serverError }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum MovieError: Error, LocalizedError {
    
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String {
        switch self {
        case .invalidURL: return "The URL was invalid, please try again later."
        case .serverError: return "There was an error with the server. Please try again later."
        case .invalidData: return "The data is invalid, please try again later."
        case .unknown(let error): return error.localizedDescription
        }
    }
}
