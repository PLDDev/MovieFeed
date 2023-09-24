//
//  MovieDetailsPresenter.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 23.09.2023.
//

import Foundation

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    weak var view: MovieDetailsViewProtocol?
    private let movieID: Int
    private var networkManager: MovieProtocol
    private var alertPresenter: AlertPresenter
    
    init(movieID: Int, networkManager: MovieProtocol, alertPresenter: AlertPresenter) {
        self.movieID = movieID
        self.networkManager = networkManager
        self.alertPresenter = alertPresenter
    }
    
    func viewDidLoad() {
        networkManager.fetchMovieDetails(id: movieID, language: "ru") { [weak self] movieModel, error in
            DispatchQueue.main.async {
                switch (movieModel, error) {
                case let (.some(movie), _):
                    self?.updateView(with: movie)
                case let (_, .some(error)):
                    self?.alertPresenter.showNetworkError(error)
                case (.none, .none):
                    self?.alertPresenter.showAlert(alertInfo: AlertInfo(title: "Неизвестная ошибка", message: "Что-то пошло не так"))
                }
            }
        }
    }
    
    private func updateView(with movie: MovieDetails) {
        view?.setTitle(movie.title)
        view?.setReleaseDate("Дата выхода: \(movie.releaseDate)")
        view?.setVoteAverage("Рейтинг: \(movie.voteAverage)/10")
        view?.setOverview("Краткое описание: \(movie.overview)")
    }
}

