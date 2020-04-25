//
//  _00AlbumTests.swift
//  100AlbumTests
//
//  Created by Kartikeya Saxena Jain on 4/25/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import XCTest

class _00AlbumTests: XCTestCase {
    let genreRock       = Genre(name: "Rock")
    let genreClassic    = Genre(name: "Classic")
    let genreMusic      = Genre(name: "Music")
    
    var album           = Album()
    var viewModel       = AlbumViewModel()

    override func setUpWithError() throws {
        album           = Album(url: "TEST URL",
                                name: "TEST NAME",
                                copyright: "TEST COPYRIGHT",
                                artistName: "TEST ARTIST",
                                releaseDate: "2020-05-01",
                                artworkUrl100: "TEST ART URL",
                                genres: [genreRock, genreMusic, genreClassic])
        
        viewModel       = AlbumViewModel(album: album)
    }
    
    func testAlbumData(){
        XCTAssertEqual(viewModel.url, "TEST URL")
        XCTAssertEqual(viewModel.name, "TEST NAME")
        XCTAssertEqual(viewModel.copyright, "TEST COPYRIGHT")
        XCTAssertEqual(viewModel.artistName, "TEST ARTIST")
        XCTAssertEqual(viewModel.artworkUrl, "TEST ART URL")
    }
    
    func testAlbumReleaseDate(){
        XCTAssertEqual(viewModel.releaseDate, "May 2020")
    }

    func testAlbumGenreCorrectFormat(){
        XCTAssertEqual(viewModel.genres, "ROCK/CLASSIC • 2020")
    }
    
    func testAlbumGenreInCorrectFormat(){
        XCTAssertNotEqual(viewModel.genres, "ROCK/MUSIC/CLASSIC • 2020")
    }
}
