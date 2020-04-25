//
//  AlbumsListVC.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

fileprivate typealias AlbumDataSource = UITableViewDiffableDataSource<Section, AlbumViewModel>
fileprivate typealias AlbumSnapshot = NSDiffableDataSourceSnapshot<Section, AlbumViewModel>

fileprivate enum Section {
    case main
}

class AlbumListVC: UIViewController {
    
    private var tableView       = UITableView()
    private var albumViewModels = [AlbumViewModel]()
    
    private var diffableDataSource: AlbumDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
        configureTableView()
        configureDataSource()
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

// MARK:- Diffable Data Source
extension AlbumListVC {
    private func configureDataSource() {
        diffableDataSource = AlbumDataSource(tableView: tableView,
                                            cellProvider: { (tableView, indexPath, viewModel) -> UITableViewCell? in
                                                let cell = tableView.dequeueReusableCell(withIdentifier: ALAlbumCell.reuseID,
                                                                                         for: indexPath) as! ALAlbumCell
                                                cell.setCell(with: viewModel)
                                                return cell
        })
    }
    
    private func createSnapshot(for viewModels: [AlbumViewModel]) {
        var snapshot = AlbumSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModels)
        diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK:- Table View
extension AlbumListVC: UITableViewDelegate {
    
    private func configureTableView(){
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 120
        tableView.delegate      = self
        
        tableView.register(ALAlbumCell.self, forCellReuseIdentifier: ALAlbumCell.reuseID)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = diffableDataSource.itemIdentifier(for: indexPath) else { return }
        
        let destVC = ALAlbumDetailVC()
        destVC.albumViewModel = viewModel
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true, completion: nil)
        
    }
}

// MARK:- Data Service Layer
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
                let viewModels = albums.map{ AlbumViewModel(album: $0) }
                self.updateUI(with: viewModels)

            }
        }
    }
    
    func updateUI(with albumViewModels: [AlbumViewModel]) {
        DispatchQueue.main.async { [weak self]  in
            guard let self = self else { return }
            
            if albumViewModels.isEmpty {
                self.showEmptyStateView(with: "Looks like no albums are available at the moment.\n 🔇")
            } else  {
                self.albumViewModels = albumViewModels
                self.createSnapshot(for: self.albumViewModels)
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}
