//
//  DetailViewController.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var choosedImageUrl: String?
    
    private let activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var catImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setImage() {
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
                
        if choosedImageUrl != nil {
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: self.choosedImageUrl!)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.catImageView.image = UIImage(data: data!)
                    
                    self.catImageView.contentMode = .scaleAspectFill
                    self.stopLoadingAnimation()
                }
            }
        }
    }
    
    fileprivate func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

}
