//
//  UIViewController + Extension.swift
//  100AlbumsOfiTunes
//
//  Created by Kartikeya Saxena Jain on 4/23/20.
//  Copyright © 2020 com.devKrey. All rights reserved.
//

import UIKit

// MARK:- Empty State Extension
fileprivate var containerView: UIView!
fileprivate var emptyView: ALEmptyStateView?

extension UIViewController {
    
    func showLoadingView() {
        containerView                   = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView               = nil
        }
    }
    
    func showEmptyStateView(with message: String) {
        emptyView                       = ALEmptyStateView(message: message)
        emptyView?.frame                = view.bounds
        view.addSubview(emptyView!)
    }
    
    func hideEmptyStateView(){
        emptyView?.removeFromSuperview()
    }
}

// MARK:- Custom Alert
extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            
            let alertVC = ALAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
