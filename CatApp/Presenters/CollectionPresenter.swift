//
//  CollectionPresenter.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class CollectionPresenter {
    
    fileprivate let urlString: String = "https://api.thecatapi.com/v1/images/search?limit=20&mime_types=jpg,png"
    
    public func loadData(completion: @escaping([CatImageData])->()) {
        var images: [CatImageData] = []
        
        let session = URLSession.shared
        let url = URL(string: urlString)!
        
        DispatchQueue.global(qos: .background).async {
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                if let items = try? JSONDecoder().decode([CatImageData].self, from: data) {
                    for item in items {
                        images.append(CatImageData(id: item.id, url: item.url))
                    }
                    completion(images)
                } else {
                    print("Invalid Response")
                }
            }
            task.resume()  
        }
    }
    
    public func loadImage(forUrl urlString: String) -> UIImage? {
        var image: UIImage?
        
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        image = UIImage(data: data!)
        
        return image
    }
}
