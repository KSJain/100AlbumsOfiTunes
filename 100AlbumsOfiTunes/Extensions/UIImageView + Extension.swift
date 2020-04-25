//
//  UIImageView + Extension.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/23/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageFor(urlString: String) {
        if urlString.count < 1 { return }
        
        NetworkManager.shared.getImageFor(imageURL: urlString) { image in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
        }
    }
}
