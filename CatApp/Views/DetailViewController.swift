//
//  DetailViewController.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var choosedImageUrl: String?
    
    let loadingView = LoadingView()

    @IBOutlet weak var catImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImage()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setImage() {
        loadingView.setLoadingView(view: self.view)
        
        if choosedImageUrl != nil {
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: self.choosedImageUrl!)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.catImageView.image = UIImage(data: data!)
                    
                    self.catImageView.contentMode = .scaleAspectFill
                    self.loadingView.removeLoadingView()
                }
            }
        }
    }
    
}
