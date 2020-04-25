//
//  Date + Extension.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthAndYear() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func convertToYear() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy"
        return dateFormatter.string(from: self)
    }
}
