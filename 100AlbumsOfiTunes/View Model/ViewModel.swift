//
//  ViewModel.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/25/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

struct AlbumViewModel: Hashable {
    let url: String
    let name: String
    let genres: String
    let copyright: String
    let artistName: String
    let artworkUrl: String
    let releaseDate: String
    
    init(album: Album = Album()) {
        self.url            = album.url
        self.name           = album.name
        self.copyright      = album.copyright
        self.artistName     = album.artistName
        self.artworkUrl     = album.artworkUrl100
        
        // Release Date
        let date            = album.releaseDate.convertToDate() ?? Date()
        let monthAndYear    = date.convertToMonthAndYear()
        self.releaseDate    = monthAndYear
        
        // Genre
        var genres          = album.genres
        var genreLableText  = ""
        
        if genres.count == 0 { genreLableText = "No Genre"}
        if genres.count >= 1 { genreLableText.append(genres.removeFirst().name)}
        
        while genres.count > 0 {
            let genre       = genres.removeFirst().name
            if genre != "Music" {
                genreLableText.append("/\(genre)")
            }
        }
        
        genreLableText.append(" • \(date.convertToYear())")
        self.genres         = genreLableText.uppercased()
    }
}
