//
//  ALEmptyStateView.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/23/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

class ALEmptyStateView: UIView {
    
    let messageLabel    = ALTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat     = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 140 : 130
        let logoTrailingConstant: CGFloat   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 120 : 160

        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.4),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.4),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: logoTrailingConstant),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        ])
    }
}
