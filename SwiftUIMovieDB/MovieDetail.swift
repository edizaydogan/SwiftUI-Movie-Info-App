//
//  MovieDetail.swift
//  SwiftUIMovieDB
//
//  Created by Ediz Aydogan on 11.08.2023.
//

import Foundation

struct MovieDetail: Decodable, Identifiable {
    let id: Int
    let title: String
    let vote_average: Double
    let vote_count: Int
    let backdrop_path: String?
    let poster_path: String?
    let overview: String?
    let runtime: Int?
    let release_date: String?
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
