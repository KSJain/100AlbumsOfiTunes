//
//  ALAlertContainerView.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/23/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class ALAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
