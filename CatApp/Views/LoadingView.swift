//
//  LoadingView.swift
//  CatApp
//
//  Created by Arina on 15.08.2021.
//

import UIKit

class LoadingView {
    
    var sublayer = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    func setLoadingView(view: UIView) {
        sublayer = UIView(frame: view.bounds)
        sublayer.backgroundColor = UIColor.systemBackground
        sublayer.alpha = 0.7
        view.addSubview(sublayer)
        
        activityIndicator.style = .large
        activityIndicator.center = sublayer.center
        sublayer.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func removeLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        sublayer.removeFromSuperview()
    }
    
}
