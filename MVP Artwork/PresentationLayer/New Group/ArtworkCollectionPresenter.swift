//
//  ArtworkCollectionPresenter.swift
//  MVP Colors
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit

protocol Reloadble: class {
    func refreshArtworks()
}

class ArtworkCollectionPresenter: NSObject {

    let model: ArtworkModel
    let backgroundColor: UIColor = .white
    let manager = ImagesManager()
    weak open var delegate: Reloadble?
    
    typealias UpdateArtworksComplSucsess = (Bool)->()
    private var artworks: [Artwork] {
        return model.artworks
    }
    private let cellIdentifier = "DefaultCell"
    
    init(with model: ArtworkModel) {
        self.model = model
    }
    
    func updateArtworkIfNeedded(index: Int) {
    
        if model.artworks.count-index < 10 {
            updateArtwork { [weak self] in
                self?.delegate?.refreshArtworks()
            }
        }
    }
    
    func updateArtwork(completion: @escaping (() -> ())) {
        self.model.getArtworks(completion: { (success) in
            if success {
                completion()
            } else {
                print("can't update artworks")
            }
        }, limit: 10, page: artworks.count)
    }
    
    func registerCells(for collectionView: UICollectionView) {
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension ArtworkCollectionPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return artworks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.contentView.layer.cornerRadius = 20.0
        cell.imageView.image = nil
 
        let artwork = artworks[indexPath.item]
        if (artwork.imageUI != nil) {
            
            
            cell.imageView.image = artwork.imageUI
            if (artwork.id == "0") {
                cell.backgroundColor = .green
            } else {
                cell.backgroundColor = .black
            }
        } else {
            
            if (artwork.id != "0") {
                manager.downloadImage(urlString: artwork.image) { (image, urlString) in
                    artwork.imageUI = image
                    OperationQueue.main.addOperation {
                        cell.imageView.image = image
                        cell.backgroundColor = .black
                    }
                }
            } else {
                self.model.getUnicAdImage(link: artwork.image, compliteImage: { (image, urlString) in
                    artwork.imageUI = image
                    artwork.image = urlString!
                    OperationQueue.main.addOperation {
                        cell.imageView.image = image
                        cell.backgroundColor = .green
                    }
                })
            }
        }
        
        return cell
    }
}
