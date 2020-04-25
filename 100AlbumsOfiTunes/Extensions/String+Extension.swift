//
//  String+Extension.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/24/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyy-MM-dd"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        return dateFormatter.date(from: self)
    }
}
