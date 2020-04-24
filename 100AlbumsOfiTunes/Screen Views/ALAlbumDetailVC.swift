//
//  ALAlbumDetailVC.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit
import SafariServices

class ALAlbumDetailVC: UIViewController {
    
    var album: Album!
    
    var storeButton         = ALButton(backgroundColor: .systemRed, title: "Buy Album")
    var albumArtView        = ALAlbumArtImageView(frame: .zero)
    var albumNameLabel      = ALTitleLabel(textAlignment: .left, fontSize: 25)
    var artistNameLabel     = ALSecondaryTitleLabel(fontSize: 25)
    var genreLabel          = ALSecondaryTitleLabel(fontSize: 12)
    var releaseDateLabel    = ALSecondaryTitleLabel(fontSize: 12)
    var copyrightInfoLabel  = ALSecondaryTitleLabel(fontSize: 12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViewElements()
    }
    
    private func setupViewElements() {
        var genres                      = album.genres
        var genreLableText              = ""
        if genres.count > 0 { genreLableText.append(genres.removeFirst().name)}
        while genres.count > 0 {
            let genre = genres.removeFirst().name
            if genre != "Music" {
                genreLableText.append("/\(genre)")
            }
        }
        
        let releaseDateText             = "Released on : \(album.releaseDate)"
        
        albumArtView.setImageFor(urlString: album.artworkUrl100)
        albumNameLabel.text             = album.name
        artistNameLabel.text            = album.artistName
        genreLabel.text                 = genreLableText.uppercased()
        releaseDateLabel.text           = releaseDateText
        copyrightInfoLabel.text         = album.copyright
        
        storeButton.addTarget(self, action: #selector(takeToStore), for: .touchUpInside)
    }
    
    private func configureView() {
        setGradient()
        configureNavigationBar()
        
        let padding: CGFloat            = 20
        let topBuffer: CGFloat          = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 70 : 120
        let widthMultiplier: CGFloat    = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0.6 : 0.83
        
        [albumArtView,
         albumNameLabel,
         artistNameLabel,
         genreLabel,
         releaseDateLabel,
         copyrightInfoLabel,
         storeButton
            ].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            albumArtView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBuffer),
            albumArtView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumArtView.widthAnchor.constraint(equalToConstant: view.bounds.width * widthMultiplier),
            albumArtView.heightAnchor.constraint(equalTo: albumArtView.widthAnchor),
            
            albumNameLabel.topAnchor.constraint(equalTo: albumArtView.bottomAnchor, constant: 15),
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            albumNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            artistNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            artistNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            genreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genreLabel.heightAnchor.constraint(equalToConstant: 27),
            
            releaseDateLabel.bottomAnchor.constraint(equalTo: copyrightInfoLabel.topAnchor, constant: -3),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            copyrightInfoLabel.bottomAnchor.constraint(equalTo: storeButton.topAnchor, constant: -12),
            copyrightInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            copyrightInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            copyrightInfoLabel.heightAnchor.constraint(equalToConstant: 15),
            
            storeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            storeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            storeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            storeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func takeToStore() {
        guard let url   = URL(string: album.url) else { return }
        let safariVC    = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    private func setGradient() {
        let layer        = CAGradientLayer()
        layer.frame      = view.bounds
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint   = CGPoint(x: 1,y: 1)
        layer.colors     = [UIColor.systemGray.cgColor, UIColor.systemGray4.cgColor, UIColor.systemGray6.cgColor].reversed() //TBD
        view.layer.addSublayer(layer)
    }
    
    private func configureNavigationBar() {
           let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(dismssVC))
           navigationItem.rightBarButtonItem   = doneButton
       }
       
       @objc private func dismssVC() {
           dismiss(animated: true)
       }
}
