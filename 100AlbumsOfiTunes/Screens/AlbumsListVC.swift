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
        
        getAlbumData(for: .us)
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
        print("Album Name: \(albums[indexPath.row].name)")
    }
}


// MARK:- Album Data
extension AlbumListVC {
    
    private func getAlbumData(for country: Country) {
        NetworkManager.shared.getAlbums(in: country) { [weak self] result in
            guard let self = self else { return }
            
            switch result  {
            case .failure(let error):
                print("Error: \(error.rawValue)")
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
