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
        
        let artwork = artworks[indexPath.row]
        if (artwork.imageUI != nil) {
            cell.imageView.image = artwork.imageUI
        } else {
            manager.downloadImage(urlString: artwork.image) { (image) in

                OperationQueue.main.addOperation {
                    artwork.imageUI = image
                    cell.imageView.image = nil
                    cell.imageView.image = artwork.imageUI
                }
            }
        }
        
        return cell
    }
}
