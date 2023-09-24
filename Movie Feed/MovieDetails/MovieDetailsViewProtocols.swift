//
//  MovieDetailsProtocols.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 23.09.2023.
//

protocol MovieDetailsViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setReleaseDate(_ date: String)
    func setVoteAverage(_ vote: String)
    func setOverview(_ overview: String)
}

protocol MovieDetailsPresenterProtocol {
    func viewDidLoad()
}
