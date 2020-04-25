//
//  Album.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

// MARK: - RSS
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
    
    init(url: String = "",
         name: String = "",
         copyright: String = "",
         artistName: String = "",
         releaseDate: String = "",
         artworkUrl100: String = "",
         genres: [Genre] = []) {
        self.url            = url
        self.name           = name
        self.copyright      = copyright
        self.artistName     = artistName
        self.releaseDate    = releaseDate
        self.artworkUrl100  = artworkUrl100
        self.genres = genres
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
    init(name: String = "") {
        self.name           = name
    }
}

