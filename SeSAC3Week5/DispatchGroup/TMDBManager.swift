//
//  File.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/18.
//

import UIKit
import Alamofire

struct TMDBManager {
    
    static let shared = TMDBManager()
    
    private init() { }
    
    func callRequestSimilarMovie(movieID: Int, completionHandler: @escaping (SimilarMovie) -> Void) {
        
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieID)")
        let apiKey = URLQueryItem(name: "api_key", value: Key.tmdb)
        let appendToResponse = URLQueryItem(name: "append_to_response", value: "similar")
        components?.queryItems = [apiKey, appendToResponse]
        
        guard let url = components?.url else { return }
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: SimilarMovie.self) { response in
                guard let value = response.value else {return}
                dump(value)
            }
        
    }
}
