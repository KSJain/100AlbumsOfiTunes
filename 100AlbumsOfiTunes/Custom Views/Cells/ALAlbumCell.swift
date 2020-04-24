//
//  ALAlbumCell.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/23/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class ALAlbumCell: UITableViewCell {
    
    static let reuseID  = "iTunesTop100AlbumCell"
    var albumArt        = ALAlbumArtImageView(frame: .zero)
    var albumName       = ALTitleLabel(textAlignment: .left, fontSize: 18)
    var artistName      = ALSecondaryTitleLabel(fontSize: 15)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(with album: Album) {
        albumArt.setImageFor(urlString: album.artworkUrl100)
        albumName.text      = album.name
        artistName.text     = album.artistName
    }
    
    private func configure() {
        let padding: CGFloat        = 8
        let imageSize: CGFloat      = 100
        albumName.numberOfLines     = 2
        accessoryType               = .disclosureIndicator
        
        [albumArt, albumName, artistName].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            albumArt.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumArt.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            albumArt.heightAnchor.constraint(equalToConstant: imageSize),
            albumArt.widthAnchor.constraint(equalToConstant: imageSize),
            
            albumName.topAnchor.constraint(equalTo: self.topAnchor),
            albumName.leadingAnchor.constraint(equalTo: albumArt.trailingAnchor, constant: padding),
            albumName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            albumName.heightAnchor.constraint(equalToConstant: 80),
            
            artistName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            artistName.leadingAnchor.constraint(equalTo: albumArt.trailingAnchor, constant: padding),
            artistName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            artistName.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
