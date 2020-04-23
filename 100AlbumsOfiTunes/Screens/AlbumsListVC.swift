//
//  AlbumsListVC.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        getAlbumData(for: .us)
    }
    
    private func getAlbumData(for country: Country) {
        NetworkManager.shared.getAlbums(in: country) { result in
            switch result  {
            case .failure(let error):
                print("Error: \(error.rawValue)")
            case .success(let albums):
                print("Album Name: \(albums.first?.name ?? "NA")")
                print("Album Artist: \(albums.first?.artistName  ?? "NA")")
                print("Album Image URL: \(albums.first?.artworkUrl100 ?? "NA")")
                
                print("Album Genre: \(albums.first?.genres.first?.name ?? "NA")")
                print("Album Copyright: \(albums.first?.copyright ?? "NA")")
                print("Album Release Date: \(albums.first?.releaseDate ?? "NA")")
                print("Album URL: \(albums.first?.url ?? "NA")")
            }
        }
    }
}
