//
//  CollectionViewController.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    fileprivate var catImages: [CatImageData] = []
    
    fileprivate var choosedImageUrl: String?
        
    fileprivate let collectionPresenter = CollectionPresenter()
    
    fileprivate var sublayer = UIView()
    fileprivate let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateImages()
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        updateImages()
    }
    
    fileprivate func setLoadingView() {
        sublayer = UIView(frame: self.view.bounds)
        sublayer.backgroundColor = UIColor.systemBackground
        sublayer.alpha = 0.7
        view.addSubview(sublayer)
        
        activityIndicator.style = .large
        activityIndicator.center = sublayer.center
        sublayer.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    fileprivate func removeLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        sublayer.removeFromSuperview()
    }
    
    fileprivate func updateImages() {
        setLoadingView()
        collectionPresenter.loadData { (images) in
            DispatchQueue.main.async {
                self.catImages = images
                self.removeLoadingView()
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCat" {
            if let destinationNavigation = segue.destination as? UINavigationController {
                if let targetController = destinationNavigation.topViewController as? DetailViewController {
                    targetController.choosedImageUrl = choosedImageUrl
                }
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        
        cell.setImageCell()
        
        DispatchQueue.global(qos: .background).async {
            let imageItem = self.catImages[indexPath.item]
            let preparedImage = self.collectionPresenter.loadImage(forUrl: imageItem.url)
            DispatchQueue.main.async {
                cell.catImage.image = preparedImage
            }
        }
    
        return cell
    }
    
    fileprivate func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        choosedImageUrl = catImages[indexPath.item].url
        performSegue(withIdentifier: "showCat", sender: self)
    }

}
