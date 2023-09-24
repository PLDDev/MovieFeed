//
//  MovieModels.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 23.09.2023.
//

import Foundation

struct PopularMoviesResponse: Decodable {
    let results: [ShortMovie]
}

struct ShortMovie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

struct MovieDetails: Decodable {
    let title: String
    let releaseDate: String
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
    }
}
