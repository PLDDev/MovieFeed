//
//  MovieEndPoint.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import Foundation
import Alamofire


enum MovieEndPoint {
    case fetchPopularMovies(language: String, page: Int)
    case fetchMovieDetails(id: Int, language: String)
    case searchMovies(query: String, language: String, page: Int)
}

extension MovieEndPoint: Routing {
    var baseUrl: String {
        return Constants.defaultApiURL
    }
    
    var path: String {
        switch self {
        case .fetchPopularMovies:
            return "/3/movie/popular"
        case .fetchMovieDetails(let id, _):
            return "/3/movie/\(id)"
        case .searchMovies:
            return "/3/search/movie"
        }
    }

    var parameters: Parameters {
        var params: Parameters = ["api_key": Constants.apiKey]
        switch self {
        case .fetchPopularMovies(let language, let page):
            params["language"] = language
            params["page"] = page
        case .fetchMovieDetails(_, let language):
            params["language"] = language
        case .searchMovies(let query, let language, let page):
            params["query"] = query
            params["language"] = language
            params["page"] = page
        }
        
        return params
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": Constants.bearerToken,
            "accept": "application/json"
        ]
    }
}

