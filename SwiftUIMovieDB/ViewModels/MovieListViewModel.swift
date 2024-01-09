//
//  MovieListViewModel.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 21.08.2023.
//

import Foundation

class MovieListViewModel: ObservableObject {

    static let shared = MovieListViewModel()
    
    let apiKey = "bb50a0729df37332d768d312a63e6aa0"
    let baseURL = "https://api.themoviedb.org/3/movie"
    
    // Called in MovieListService
    func fetchMovieList(from endpoint: MovieListEndpoint, page: Int) async throws -> [Movie] {
        let urlString = "\(baseURL)/\(endpoint.rawValue)?page=\(page)&region=US&api_key=\(apiKey)"
        guard let movieResponse: MovieResponse = try await StaticJSONDecoder.loadURLAndDecode(with: urlString) else { throw MovieError.invalidData }
        return movieResponse.results
    }
}
