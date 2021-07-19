//
//  CollectionViewCell.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    
    public func setImageCell() {
        self.layer.cornerRadius = 15
        
        catImage.contentMode = .scaleAspectFill
        catImage.image = UIImage(named: "loadingSquare")
    }
    
}
