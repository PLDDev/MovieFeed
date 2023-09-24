//
//  FeedViewController.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import UIKit
import Kingfisher
import SnapKit

final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView = UITableView()
    private var networkManager: MovieProtocol
    private var presenter: FeedPresenterProtocol
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Init
    
    init(presenter: FeedPresenterProtocol, networkManager: MovieProtocol) {
        self.presenter = presenter
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.loadMovies(page: presenter.currentPage)
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.isSearchActive ? presenter.filteredMovies.count : presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = presenter.isSearchActive ? presenter.filteredMovies[indexPath.row] : presenter.movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        
        if let posterPath = movie.posterPath {
            let baseURL = "https://image.tmdb.org/t/p/w500/"
            let fullURL = URL(string: baseURL + posterPath)
            cell.posterImageView.kf.setImage(with: fullURL, placeholder: UIImage(named: "placeholder"))
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectMovie(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.movies.count - 1  {
            presenter.willDisplayLastCell()
        }
    }
}

// MARK: - UISearch

extension FeedViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            presenter.isSearchActive = false
            tableView.reloadData()
            return
        }
        presenter.performSearch(query: query)
    }
}

// MARK: - FeedViewProtocol

extension FeedViewController: FeedViewProtocol {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func navigateToMovieDetailScreen(with movieID: Int) {
        let detailsViewController = MovieDetailsViewController()
        let detailsPresenter = MovieDetailsPresenter(
            movieID: movieID,
            networkManager: MovieNetworkManager(),
            alertPresenter: AlertPresenter(viewController: detailsViewController))
        detailsPresenter.view = detailsViewController
        detailsViewController.presenter = detailsPresenter
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

// MARK: - UI Configuration

private extension FeedViewController {
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск фильмов"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = .zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
    }
}

