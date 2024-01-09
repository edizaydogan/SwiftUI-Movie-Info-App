//
//  MovieListService.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 16.08.2023.
//

import Foundation

class MovieListService: ObservableObject {
    
    @Published var movies = [Movie]()
    @Published var error: Error?
    
    var pageNumber = 1
    
    func loadData(with endpoint: MovieListEndpoint) {
        Task(priority: .medium) {
            try await loadMoviesFromEndpoint(from: endpoint)
        }
    }
    
    @MainActor
    func loadMoviesFromEndpoint(from endpoint: MovieListEndpoint) async throws{
        do {
            let movies = try await MovieListViewModel.shared.fetchMovieList(from: endpoint, page: pageNumber)
            self.movies.append(contentsOf: movies)
        } catch {
            self.error = error
        }
    }
}

extension MovieListService {
    
    func handleRefresh(endpoint: MovieListEndpoint) {
        pageNumber = 1
        self.movies.removeAll()
        loadData(with: endpoint)
    }
    
    func loadNewPage(endpoint: MovieListEndpoint) {
        pageNumber += 1
        loadData(with: endpoint)
    }
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {

    var id: String { rawValue }

    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular

    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}
