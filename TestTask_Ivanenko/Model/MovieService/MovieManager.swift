//
//  MovieManager.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 24.12.2023.
//

import Foundation

protocol MovieManager: AnyObject {
    var movies: [Movie] { get }
    func loadMovies(completion: @escaping ([Movie]) -> ())
    func updateMovie(withId id: Int, newValue value: Movie, completion: @escaping (String) -> ())
}

final class MovieManagerImpl: MovieManager {
    var movies: [Movie] = []
    
    func loadMovies(completion: @escaping ([Movie]) -> ()) {
        fetchMovies { (response) in
            self.movies = response
            completion(response)
        }
    }
    
    func updateMovie(withId id: Int, newValue value: Movie, completion: @escaping (String) -> ()) {
        for i in 0..<self.movies.count {
            if movies[i].id == id {
                self.movies[i].isOnTheWatchlist = value.isOnTheWatchlist
            }
        }
        completion("Successfully updated movie with id \(id)")
    }
}

// MARK: - Private
private extension MovieManagerImpl {
    func fetchMovies(completion: @escaping ([Movie]) -> ()) {
        let responseMovies = [Movie(id: 0,
                                    title: "Tenet",
                                    description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.",
                                    rating: 7.8,
                                    duration: DateComponents(hour: 2, minute: 30),
                                    genre: [.action, .sciFi],
                                    releaseDate: parseDate(date: "03/09/2020"),
                                    trailerLink: parseURL(url: "https://www.youtube.com/watch?v=LdOM0x0XDMo"),
                                    imageName: "Tenet",
                                    isOnTheWatchlist: false
                                   ),
                              Movie(id: 1,
                                    title: "Spider-Man: Into the Spider-Verse",
                                    description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
                                    rating: 8.4,
                                    duration: DateComponents(hour: 1, minute: 57),
                                    genre: [.action, .animation, .adventure],
                                    releaseDate: parseDate(date: "14/12/2018"),
                                    trailerLink: parseURL(url: "​https://www.youtube.com/watch?v=tg52up16eq0"),
                                    imageName: "Spider Man",
                                    isOnTheWatchlist: false
                                   ),
                              Movie(id: 2,
                                    title: "Knives Out",
                                    description: "A detective investigates the death of a patriarch of an eccentric, combative family.",
                                    rating: 7.9,
                                    duration: DateComponents(hour: 2, minute: 10),
                                    genre: [.comedy, .crime, .drama],
                                    releaseDate: parseDate(date: "27/11/2019"),
                                    trailerLink: parseURL(url: "https://www.youtube.com/watch?v=qGqiHJTsRkQ"),
                                    imageName: "Knives Out",
                                    isOnTheWatchlist: true
                                   ),
                              Movie(id: 3,
                                    title: "Guardians of the Galaxy",
                                    description: "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.",
                                    rating: 8.0,
                                    duration: DateComponents(hour: 2, minute: 1),
                                    genre: [.action, .adventure, .comedy],
                                    releaseDate: parseDate(date: "01/08/2014"),
                                    trailerLink: parseURL(url: "https://www.youtube.com/watch?v=d96cjJhvlMA"),
                                    imageName: "Guardians of The Galaxy",
                                    isOnTheWatchlist: false
                                   ),
                              Movie(id: 4, 
                                    title: "Avengers: Age of Ultron",
                                    description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.",
                                    rating: 7.3,
                                    duration: DateComponents(hour: 2, minute: 21),
                                    genre: [.action, .adventure, .sciFi],
                                    releaseDate: parseDate(date: "01/05/2015"),
                                    trailerLink: parseURL(url: "https://www.youtube.com/watch?v=tmeOjFno6Do"),
                                    imageName: "Avengers",
                                    isOnTheWatchlist: false
                                   )]
        completion(responseMovies)
    }
    
    func parseDate(date: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: date) ?? Date()
    }
    
    func parseURL(url: String) -> URL {
        return URL(string: url) ?? URL(string: "http://example.com")!
    }
}
