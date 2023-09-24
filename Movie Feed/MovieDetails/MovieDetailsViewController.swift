//
//  MovieDetailsViewController.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 22.09.2023.
//

import UIKit
import SnapKit

final class MovieDetailsViewController: UIViewController{
    
    // MARK: - Properties
    
    var presenter: MovieDetailsPresenterProtocol!
    
    private let titleIcon = UIImageView(image: UIImage(systemName: "film"))
    private let releaseDateIcon = UIImageView(image: UIImage(systemName: "calendar"))
    private let voteAverageIcon = UIImageView(image: UIImage(systemName: "star.fill"))
    private let overviewIcon = UIImageView(image: UIImage(systemName: "text.justify"))

    private let titleLabel = makeLabel(numberOfLines: 0, fontSize: 24, textColor: .darkGray)
    private let releaseDateLabel = makeLabel(fontSize: 18, textColor: .darkGray)
    private let voteAverageLabel = makeLabel(fontSize: 18, textColor: .darkGray)
    private let overviewLabel = makeLabel(numberOfLines: 0, fontSize: 16, textColor: .black)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViews()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private static func makeLabel(numberOfLines: Int = 1, fontSize: CGFloat = 17, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = numberOfLines
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        if numberOfLines > 1 {
            label.lineBreakMode = .byWordWrapping
        }
        return label
    }

    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(voteAverageLabel)
        view.addSubview(overviewLabel)
        view.addSubview(titleIcon)
        view.addSubview(releaseDateIcon)
        view.addSubview(voteAverageIcon)
        view.addSubview(overviewIcon)
        
        // Label layout code
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
        }

        releaseDateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }

        voteAverageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(30)
        }

        overviewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(voteAverageLabel.snp.bottom).offset(30)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        // Icon layout code
        
        titleIcon.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel.snp.leading).offset(-10)
        }
        
        releaseDateIcon.snp.makeConstraints { make in
            make.centerY.equalTo(releaseDateLabel)
            make.trailing.equalTo(releaseDateLabel.snp.leading).offset(-10)
        }
        
        voteAverageIcon.snp.makeConstraints { make in
            make.centerY.equalTo(voteAverageLabel)
            make.trailing.equalTo(voteAverageLabel.snp.leading).offset(-10)
        }
        
        overviewIcon.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel).offset(5)
            make.leading.equalTo(overviewLabel).offset(-20)
        }
    }
}

// MARK: - MovieDetailsViewProtocol

extension MovieDetailsViewController: MovieDetailsViewProtocol {
    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setReleaseDate(_ date: String) {
        releaseDateLabel.text = date
    }

    func setVoteAverage(_ vote: String) {
        voteAverageLabel.text = vote
    }

    func setOverview(_ overview: String) {
        overviewLabel.text = overview
    }
}
