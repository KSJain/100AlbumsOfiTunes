//
//  ALNetworkError.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/21/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

// MARK: - Error
enum ALNetworkError: String, Error {
    case badURL         = "Please go to settings and make the country sellection"
    case badData        = "We got the data for you but it was unreliable"
    case urlError       = "There was a network related error. Please try again later"
    case badResponse    = "The network response  code was invalid. please try again"
    case decodeError    = "We tried to get the data u needed, but failed"
}
