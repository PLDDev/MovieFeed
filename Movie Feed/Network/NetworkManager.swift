//
//  NetworkManager.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import Alamofire

// протокол получает запрошенную модель погоды или возвращает ошибку
protocol MovieProtocol {
    typealias PopularMoviesCompletionBlock = (_ movieModel: PopularMoviesResponse?, _ error: AFError?) -> ()
    typealias MovieDetailsCompletionBlock = (_ movieModel: MovieDetails?, _ error: AFError?) -> ()
    typealias SearchMoviesCompletionBlock = (_ movieModel: PopularMoviesResponse?, _ error: AFError?) -> ()
    func searchMovies(query: String, language: String, page: Int, completion: @escaping SearchMoviesCompletionBlock)
    
    func fetchPopularMovies(language: String, page: Int, completion: @escaping PopularMoviesCompletionBlock)
    func fetchMovieDetails(id: Int, language: String, completion: @escaping MovieDetailsCompletionBlock)
}


//класс соверешает запрос через alamofire к api погоды и возвращает нам данные или ошибку
class MovieNetworkManager: MovieProtocol {
    
    func fetchPopularMovies(language: String, page: Int, completion: @escaping PopularMoviesCompletionBlock) {
        NetRouter<MovieEndPoint, PopularMoviesResponse>().request(.fetchPopularMovies(language: language, page: page)) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchMovieDetails(id: Int, language: String, completion: @escaping MovieDetailsCompletionBlock) {
        NetRouter<MovieEndPoint, MovieDetails>().request(.fetchMovieDetails(id: id, language: language)) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchMovies(query: String, language: String, page: Int, completion: @escaping SearchMoviesCompletionBlock) {
        NetRouter<MovieEndPoint, PopularMoviesResponse>().request(.searchMovies(query: query, language: language, page: page)) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}



