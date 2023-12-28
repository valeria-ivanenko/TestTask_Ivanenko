//
//  MovieListTableViewCell.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 26.12.2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var onMyWatchlistLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        self.onMyWatchlistLabel.isHidden = false
    }
    
    // MARK: - Setup
    func setup(movie: Movie) {
        self.moviePosterImageView.image = UIImage(named: movie.imageName)
        let year = Calendar.current.dateComponents([.year], from: movie.releaseDate).year ?? 0
        self.titleLabel.text = "\(movie.title) (\(year))"
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        var genreString = ""
        for genre in movie.genre {
            if !genreString.isEmpty {
                genreString += ", "
            }
            genreString += genre.rawValue
        }
        self.descriptionLabel.text = "\(formatter.string(from: movie.duration) ?? "") - \(genreString)"
        self.onMyWatchlistLabel.isHidden = movie.isOnTheWatchlist ? false : true
    }
}

// MARK: - Private
private extension MovieListTableViewCell {
    func setupView() {
        moviePosterImageView.layer.shadowColor = UIColor.black.cgColor
        moviePosterImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        moviePosterImageView.layer.shadowOpacity = 0.3
        moviePosterImageView.layer.shadowRadius = 4.0
    }
}
