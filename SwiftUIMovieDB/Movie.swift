//
//  Movie.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 11.08.2023.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let vote_average: Double
    let backdrop_path: String?
    let poster_path: String?
    let release_date: String?
    let overview: String?
}
