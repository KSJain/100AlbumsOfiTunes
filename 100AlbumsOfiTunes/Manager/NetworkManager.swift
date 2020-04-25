//
//  NetworkManager.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class NetworkManager{
    
    // MARK: - Singelton
    static var shared = NetworkManager()
    private let baseURL = "https://rss.itunes.apple.com/api/v1"
    private var imageCache      = NSCache<NSString, UIImage>()

    private init() {}
    
    func getAlbums(in country: Country, completion: @escaping (Result<[Album], ALNetworkError>) -> Void) {
        
        let endpoint = baseURL + "/\(country.rawValue)" + "/itunes-music/top-albums/all/100/explicit.json"
        
        //MARK:- HINT, Intentioanlly leaving bad URL to show unhappy path.
//        Uncomment below to see behaviour, and comment above
//        let endpoint = baseURL + "/\(country.rawValue)" + "/itunefs-music/top-albums/all/100/explicit.json"

        
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
                let rss = try decoder.decode(RSS.self, from: jsonData)
                let albums  = rss.feed.results
                completion(.success(albums))
                
            } catch {
                completion(.failure(.decodeError))
            }
            
            
        }
        task.resume()
    }
    
    func getImageFor(imageURL: String, completion: @escaping (UIImage) -> Void)  {
        let cacheKey = NSString(string: imageURL)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: imageURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if  let _ = error  { return }
            guard let  resp  = response as? HTTPURLResponse,  resp.statusCode ==  200 else { return }
            guard let imageData = data else { return }
            
            if let avatarImage = UIImage(data: imageData) {
                self.imageCache.setObject(avatarImage, forKey: cacheKey)
                completion(avatarImage)
            }
        }
        
        task.resume()
    }
}
