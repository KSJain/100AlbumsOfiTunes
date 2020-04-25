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
    
    var albumViewModel: AlbumViewModel!
    
    var artistNameLabel                 = ALSecondaryTitleLabel(fontSize: 25)
    var genreLabel                      = ALSecondaryTitleLabel(fontSize: 12)
    var releaseDateLabel                = ALSecondaryTitleLabel(fontSize: 12)
    var copyrightInfoLabel              = ALSecondaryTitleLabel(fontSize: 12)
    var albumArtView                    = ALAlbumArtImageView(frame: .zero)
    var albumNameLabel                  = ALTitleLabel(textAlignment: .left, fontSize: 25)
    var musicAppButton                     = ALButton(backgroundColor: .systemRed, title: "Open in Music")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupViewElements()
    }
    
    private func setupViewElements() {
        
        albumNameLabel.text             = albumViewModel.name
        artistNameLabel.text            = albumViewModel.artistName
        genreLabel.text                 = albumViewModel.genres
        releaseDateLabel.text           = albumViewModel.releaseDate
        copyrightInfoLabel.text         = albumViewModel.copyright
        
        albumArtView.setImageFor(urlString: albumViewModel.artworkUrl)
        musicAppButton.addTarget(self, action: #selector(takeToStore), for: .touchUpInside)
    }
    
    private func configureView() {
        setGradient()
        configureNavigationBar()
        
        let padding: CGFloat            = 20
        let topBuffer: CGFloat          = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 70 : 120
        let widthMultiplier: CGFloat    = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0.6 : 0.83
        
        view.addSubview(albumArtView)
        genreLabel.numberOfLines        = 4
        
        [albumNameLabel,
         artistNameLabel,
         genreLabel,
         releaseDateLabel,
         copyrightInfoLabel,
         musicAppButton
            ].forEach {
                view.addSubview($0)
                NSLayoutConstraint.activate([
                    $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                ])
                
        }
        
        NSLayoutConstraint.activate([
            albumArtView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBuffer),
            albumArtView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumArtView.widthAnchor.constraint(equalToConstant: view.bounds.width * widthMultiplier),
            albumArtView.heightAnchor.constraint(equalTo: albumArtView.widthAnchor),
            
            albumNameLabel.topAnchor.constraint(equalTo: albumArtView.bottomAnchor, constant: 15),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 27),
            
            genreLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 8),
            genreLabel.heightAnchor.constraint(equalToConstant: 52),
            
            releaseDateLabel.bottomAnchor.constraint(equalTo: copyrightInfoLabel.topAnchor, constant: -3),
            releaseDateLabel.heightAnchor.constraint(equalToConstant: 15),
            
            copyrightInfoLabel.bottomAnchor.constraint(equalTo: musicAppButton.topAnchor, constant: -12),
            copyrightInfoLabel.heightAnchor.constraint(equalToConstant: 15),
            
            musicAppButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            musicAppButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func takeToStore() {
        guard let url = URL(string: albumViewModel.url) else { return }
        
        let application     = UIApplication.shared
        
        if application.canOpenURL(url) {
            application.open(url, options: [:], completionHandler: nil)
        } else {
            let safariVC    = SFSafariViewController(url: url)
            safariVC.preferredControlTintColor = .systemGreen
            present(safariVC, animated: true)
        }
    }
    
    private func setGradient() {
        let layer                       = CAGradientLayer()
        layer.frame                     = view.bounds
        layer.startPoint                = CGPoint(x: 0,y: 0)
        layer.endPoint                  = CGPoint(x: 1,y: 1)
        layer.colors                    = [UIColor.systemGray6.cgColor,
                                           UIColor.systemGray5.cgColor,
                                           UIColor.systemGray2.cgColor,
                                           UIColor.systemGray.cgColor]
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
