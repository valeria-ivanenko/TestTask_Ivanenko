//
//  MovieDetailsViewController.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 27.12.2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - Properties
    var movie: Movie? = nil
    var delegate: MovieUpdator? = nil
    
    // MARK: - Outlets
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @IBAction func watchlistTapped(_ sender: Any) {
        self.movie?.isOnTheWatchlist.toggle()
        updateWatchlistButtonText()
        guard let movie = self.movie else { return }
        self.delegate?.updateMovie(withId: movie.id, newValue: movie)
    }
    
    @IBAction func watchTrailerTapped(_ sender: Any) {
        guard let movie = self.movie else { return }
        UIApplication.shared.open(movie.trailerLink)
    }
}

// MARK: - Ptivate
private extension MovieDetailsViewController {
    func setupView() {
        guard let movie = self.movie else { return }
        self.moviePosterImageView.image = UIImage(named: movie.imageName)
        moviePosterImageView.layer.shadowColor = UIColor.black.cgColor
        moviePosterImageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        moviePosterImageView.layer.shadowOpacity = 0.3
        moviePosterImageView.layer.shadowRadius = 4.0
        
        self.titleLabel.text = movie.title
        let attributedText = NSMutableAttributedString(string: "\(movie.rating)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributedText.append(NSAttributedString(string:"/10", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        self.ratingLabel.attributedText = attributedText
        self.watchlistButton.titleLabel?.adjustsFontSizeToFitWidth = false
        updateWatchlistButtonText()
        self.descriptionLabel.text = movie.description
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
        watchTrailerButton.backgroundColor = .clear
        watchTrailerButton.layer.cornerRadius = 10
        watchTrailerButton.layer.borderWidth = 1
        watchTrailerButton.layer.borderColor = UIColor.black.cgColor
        self.genreLabel.text = genreString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, d MMMM"
        let formattedDate = dateFormatter.string(from: movie.releaseDate)
        self.releaseDateLabel.text = formattedDate
    }
    
    func updateWatchlistButtonText() {
        guard let movie = self.movie else { return }
        watchlistButton.setTitle(movie.isOnTheWatchlist ? "  REMOVE FROM WATCHLIST  " : "  + ADD TO WATCHLIST  ", for: .normal)
    }
}

protocol MovieUpdator {
    func updateMovie(withId id: Int, newValue value: Movie)
}
