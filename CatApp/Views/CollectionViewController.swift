//
//  CollectionViewController.swift
//  CatApp
//
//  Created by Arina on 19.07.2021.
//

import UIKit

class CollectionViewController: UICollectionViewController, CollectionPresenterDelegate {
    
    private var catImages: [CatImageData] = []
    
    private var choosedImageUrl: String?
        
    private let collectionPresenter = CollectionPresenter()
    private let loadingView = LoadingView()
    
    private var sublayer = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionPresenter.setViewDelegate(delegate: self)
        updateCats()
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        updateCats()
    }
    
    private func updateCats() {
        loadingView.setLoadingView(view: self.view)
        collectionPresenter.loadData()
        loadingView.removeLoadingView()
    }
    
    // MARK: - Collection Presenter Delegate
    
    func presentCats(cats: [CatImageData]) {
        self.catImages = cats
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
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
