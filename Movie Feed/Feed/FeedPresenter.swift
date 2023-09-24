//
//  FeedPresenter.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 23.09.2023.
//

import Foundation

final class FeedPresenter: FeedPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: FeedViewProtocol?
    var networkManager: MovieProtocol
    var movies: [ShortMovie] = []
    var currentPage = 1
    var isLoading = false
    var filteredMovies: [ShortMovie] = []
    var isSearchActive = false
    
    private var alertPresenter: AlertPresenter?
    
    // MARK: - Init
    
    init(networkManager: MovieProtocol, alertPresenter: AlertPresenter) {
        self.networkManager = networkManager
        self.alertPresenter = alertPresenter
    }
    
    // MARK: - FeedPresenter Methods
    
    func didSelectMovie(at indexPath: IndexPath) {
        let movie = isSearchActive ? filteredMovies[indexPath.row] : movies[indexPath.row]
        view?.navigateToMovieDetailScreen(with: movie.id)
    }

    func willDisplayLastCell() {
        if !isLoading {
            loadMovies(page: currentPage)
        }
    }
    
    func performSearch(query: String) {
        networkManager.searchMovies(query: query, language: "ru", page: 1) { [weak self] (response, error) in
            switch (response, error) {
            case let (.some(moviesResponse), _):
                self?.filteredMovies = moviesResponse.results
                self?.isSearchActive = true
                DispatchQueue.main.async {
                    self?.view?.reloadTable()
                }
            case let (_, .some(error)):
                self?.alertPresenter?.showNetworkError(error)
            case (.none, .none):
                self?.alertPresenter?.showAlert(alertInfo: AlertInfo(title: "Неизвестная ошибка", message: "Что-то пошло не так"))
            }
        }
    }
    
    func loadMovies(page: Int) {
        isLoading = true
        
        networkManager.fetchPopularMovies(language: "ru", page: page) { [weak self] (response, error) in
            switch (response, error) {
            case let (.some(moviesResponse), _):
                self?.movies += moviesResponse.results
                self?.currentPage += 1
                DispatchQueue.main.async {
                    self?.view?.reloadTable()
                }
            case let (_, .some(error)):
                self?.alertPresenter?.showNetworkError(error)
            case (.none, .none):
                self?.alertPresenter?.showAlert(alertInfo: AlertInfo(title: "Неизвестная ошибка", message: "Что-то пошло не так"))
            }
            self?.isLoading = false
        }
    }
}

