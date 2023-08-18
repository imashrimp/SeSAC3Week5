//
//  SimilarMovieModel.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import Foundation

// MARK: - Movie
struct SimilarMovie: Codable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let title: String
    let similar: Similar

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case similar
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}


// MARK: - Similar
struct Similar: Codable {
    let page: Int
    let results: [SimilarFilms]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarFilms: Codable {
    let genreIDS: [Int]
    let id: Int
    let overview: String
    let posterPath: String?
    let releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
