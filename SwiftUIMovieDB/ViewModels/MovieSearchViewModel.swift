//
//  MovieSearchViewModel.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 15.08.2023.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    
    @Published var searchedMovies = [Movie]()
    @Published var error: Error?
    
    let apiKey = "bb50a0729df37332d768d312a63e6aa0"
    let baseURL = "https://api.themoviedb.org/3/search/movie?query="
    
    @MainActor
    func searchMovie(query: String) async throws {
        let urlString = "\(baseURL)\(query)&api_key=\(apiKey)"
        do {
            guard let movie: MovieResponse = try await StaticJSONDecoder.loadURLAndDecode(with: urlString) else { throw MovieError.invalidData }
            self.searchedMovies = movie.results
        } catch {
            self.error = error
        }
    }
}
