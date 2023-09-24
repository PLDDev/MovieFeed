//
//  FeedViewProtocols.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 23.09.2023.
//

import UIKit

protocol FeedPresenterProtocol {
    var view: FeedViewProtocol? { get set }
    var currentPage: Int { get }
    var isLoading: Bool { get }
    var movies: [ShortMovie] { get }
    var filteredMovies: [ShortMovie] { get set }
    var isSearchActive: Bool { get set }
    func loadMovies(page: Int)
    func performSearch(query: String)
    func didSelectMovie(at indexPath: IndexPath)
    func willDisplayLastCell()
}

protocol FeedViewProtocol: AnyObject {
    func reloadTable()
    func navigateToMovieDetailScreen(with movieID: Int)
}

