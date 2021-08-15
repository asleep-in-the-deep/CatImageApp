//
//  CollectionPresenter.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

protocol CollectionPresenterDelegate: AnyObject {
    func presentCats(cats: [CatImageData])
    func presentAlert(title: String, message: String)
}

class CollectionPresenter {
    
    private let urlString: String = "https://api.thecatapi.com/v1/images/search?limit=20&mime_types=jpg,png"
    
    weak var delegate: CollectionPresenterDelegate?
    
    public func setViewDelegate(delegate: CollectionPresenterDelegate) {
        self.delegate = delegate
    }
    
    func loadData() {
            let session = URLSession.shared
            let url = URL(string: urlString)!
    
            DispatchQueue.global(qos: .background).async {
                let task = session.dataTask(with: url) { data, response, error in
                    guard let data = data else { return }
    
                    if let cats = try? JSONDecoder().decode([CatImageData].self, from: data) {
                        self.delegate?.presentCats(cats: cats)
                    } else {
                        self.delegate?.presentAlert(title: "Error loading data", message: "Please try again later")
                    }
                }
                task.resume()
            }
        }

    
    func loadImage(forUrl urlString: String) -> UIImage? {
        var image: UIImage?
        
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        image = UIImage(data: data!)
        
        return image
    }
}
