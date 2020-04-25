//
//  Album.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct RSS: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let results: [Album]
}

// MARK: - Result
struct Album: Codable {
    let url: String
    let name: String
    let copyright: String
    let artistName: String
    let releaseDate: String
    let artworkUrl100: String
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}

