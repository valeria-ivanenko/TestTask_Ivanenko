//
//  MovieListViewController.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 24.12.2023.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Properties
    private var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieListTableView.reloadData()
            }
        }
    }
    
    // MARK: - Services
    private let movieManager: MovieManager = MovieManagerImpl()
    
    // MARK: - Outlets
    @IBOutlet private weak var movieListTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        setupView()
        
        movieManager.loadMovies { [weak self] (movies) in
            self?.movies = movies
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.movieListTableView.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction private func sortTapped(_ sender: Any) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let sortByTitleAction = UIAlertAction(title: "Title", style: .default) { [weak self] _ in
            self?.getSortedByTitleMovies()
        }
        let sortByReleaseDateAction = UIAlertAction(title: "Release Date", style: .default) { [weak self] _ in
            self?.getSortedByReleaseDateMovies()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        
        actionSheetController.addAction(sortByTitleAction)
        actionSheetController.addAction(sortByReleaseDateAction)
        actionSheetController.addAction(cancelAction)

        self.present(actionSheetController, animated: true, completion: nil)
    }
}

// MARK: - Private
private extension MovieListViewController {
    func setupView() {
        let nib = UINib(nibName: "MovieListTableViewCell", bundle: nil)
        movieListTableView.register(nib, forCellReuseIdentifier: "MovieListTableViewCell")
    }
    
    func getSortedByTitleMovies() {
        self.movies = self.movies.sorted(by: { $0.title < $1.title })
    }
    
    func getSortedByReleaseDateMovies() {
        self.movies = self.movies.sorted(by: { $0.releaseDate > $1.releaseDate })
    }
}


// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let movieDetailsScene = storyboard.instantiateViewController(
                withIdentifier: "MovieDetailsViewController"
            ) as? MovieDetailsViewController
        else {
            return
        }
        let movie = self.movies[indexPath.row]
        movieDetailsScene.movie = movie
        movieDetailsScene.delegate = self
        
        navigationController?.pushViewController(movieDetailsScene, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.movies.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.movieListCellIdentifier, for: indexPath) as? MovieListTableViewCell else {
            fatalError("Error: unable to dequeue cell with identifier \(Constant.movieListCellIdentifier)")
        }
        let movie = movies[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        self.movieListTableView.bounds.height / 4
    }
}

//MARK: - MovieUpdator
extension MovieListViewController: MovieUpdator {
    func updateMovie(withId id: Int, newValue value: Movie) {
        self.movieManager.updateMovie(withId: id, newValue: value) { response in
            print(response)
        }
        self.movies = self.movieManager.movies
    }
}

// MARK: - Constants
private enum Constant {
    static let movieListCellIdentifier = String(describing: MovieListTableViewCell.self)
}
