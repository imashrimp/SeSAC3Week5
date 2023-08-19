//
//  VideoModel.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/19.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let backdropPath: String
    let id: Int
    let imdbID: String
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let title: String
    let video: Bool
    let videos: Videos

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case imdbID = "imdb_id"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title, video
        case videos
    }
}

// MARK: - Videos
struct Videos: Codable {
    let results: [VideoInfo]
}

// MARK: - Result
struct VideoInfo: Codable {
    let name: String
    let site: String
    let type: String
    let official: Bool
    let publishedAt: String

    enum CodingKeys: String, CodingKey {
        case name, site, type, official
        case publishedAt = "published_at"
    }
}
