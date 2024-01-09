//
//  MovieDetailViewModel.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 15.08.2023.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    
    @Published var selectedMovie: MovieDetail?
    @Published var error: Error?
    
    let apiKey = "bb50a0729df37332d768d312a63e6aa0"
    let baseURL = "https://api.themoviedb.org/3/movie/"
    
    @MainActor
    func fetchMovieDetail(with movieId: Int) async throws {
        let urlString = "\(baseURL)\(movieId)?api_key=\(apiKey)"
        do {
            guard let movieDetail: MovieDetail = try await StaticJSONDecoder.loadURLAndDecode(with: urlString) else { throw MovieError.invalidData }
            self.selectedMovie = movieDetail
        } catch {
            self.error = error
        }
    }
}

extension MovieDetailViewModel {
    // Runtime Formatter
    func minutesToHoursMinutes(_ minutes: Int) -> (Int, Int) {
        return (minutes / 60, minutes % 60)
    }
    // Async function for the time required to fetch data
    func sleepHalfSecond() async {
        // Simulate some network request
        try? await Task.sleep(nanoseconds: 500_000_000)
    }
}
