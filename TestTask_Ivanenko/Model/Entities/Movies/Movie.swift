//
//  Movie.swift
//  TestTask_Ivanenko
//
//  Created by Valeriia Ivanenko on 24.12.2023.
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let description: String
    let rating: Double
    let duration: DateComponents
    let genre: Set<Genre>
    let releaseDate: Date
    let trailerLink: URL
    let imageName: String
    var isOnTheWatchlist: Bool
}
