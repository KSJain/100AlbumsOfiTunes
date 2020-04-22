//
//  NetworkManager.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

class NetworkManager{
    
    // MARK: - Singelton
    static var shared = NetworkManager()
    private let baseURL = "https://rss.itunes.apple.com/api/v1"
    
    private init() {}
    
    func getAlbums(in country: Country, completion: @escaping (Result<[Album], ALNetworkError>) -> Void) {
        
        let endpoint = baseURL + "/\(country.rawValue)" + "/itunes-music/top-albums/all/100/explicit.json"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { oData, oResponse, oError in
            
            if oError != nil {
                completion(.failure(.urlError))
                return
            }
            
            guard let response = oResponse as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let jsonData = oData else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let rss = try decoder.decode(Welcome.self, from: jsonData)
                let albums  = rss.feed.results
                completion(.success(albums))
                
            } catch {
                completion(.failure(.decodeError))
            }
            
            
        }
        task.resume()
    }
}
