//
//  AlbumsListVC.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController {
    
    var tableView       = UITableView()
    var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        getAlbumData(for: .error)
    }
}

// MARK:- View Configuartion
extension AlbumListVC {
    
    private func configureViewController()  {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK:- Table View Configuration
extension AlbumListVC: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 120
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(ALAlbumCell.self, forCellReuseIdentifier: ALAlbumCell.reuseID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ALAlbumCell.reuseID, for: indexPath) as! ALAlbumCell
        cell.setCell(with: albums[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = ALAlbumDetailVC()
        destVC.album = albums[indexPath.row]
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true, completion: nil)
        
    }
}


// MARK:- Album Data
extension AlbumListVC {
    
    private func getAlbumData(for country: Country) {
        NetworkManager.shared.getAlbums(in: country) { [weak self] result in
            guard let self = self else { return }
            
            switch result  {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "OOPS  🚧",
                                                message: "\(error.rawValue)",
                                                buttonTitle: "OK")
                self.updateUI(with: [])
            case .success(let albums):
                self.updateUI(with: albums)

            }
        }
    }
    
    func updateUI(with albums: [Album]) {
        DispatchQueue.main.async { [weak self]  in
            guard let self = self else { return }
            
            if albums.isEmpty {
                self.showEmptyStateView(with: "Looks like no albums are available at the moment.\n 🔇")
            } else  {
                self.albums = albums
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}
