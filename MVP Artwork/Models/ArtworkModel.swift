//
//  ArtworkModel.swift
//  MVP Colors
//
//  Created by Zhenia Pasko on 6/20/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit

class ArtworkModel {
    var artworks: [Artwork] = []
    private var ads: [Artwork] = []
    
    let networkLayer: NetworkManager
    let loadImagesLayer: ImagesManager
    
    init(with networkLayer: NetworkManager, and loadImagesManager: ImagesManager) {
        self.networkLayer = networkLayer
        self.loadImagesLayer = loadImagesManager
    }
    
    func getArtworks(completion: @escaping ArtworkCollectionPresenter.UpdateArtworksComplSucsess, limit: Int, page: Int) {
        
        networkLayer.getNewArtworks(limit: limit, page: page, completion: { [weak self] artworks, error in
            
            guard let artworks = artworks else {
                completion(false)
                return
            }
            self?.artworks.append(contentsOf: artworks)
            
            let countArtworks = (self?.artworks.count) ?? 0
            let countAds = (self?.ads.count) ?? 0
            if ((countArtworks-countAds)%20==0 && (countArtworks != 0)) {
                let artworkAd = Artwork(image: nil, imageUrl: "https://loremflickr.com/620/440?random=1", id: "0")
                self?.artworks.append(artworkAd)
                self?.ads.append(artworkAd)
            }
            
            completion(true)
        })
    }
    
    func getUnicAdImage(link: String, compliteImage: @escaping (_ image: UIImage?, _ filePath: String?)->()) {
        
        loadImagesLayer.downloadImage(urlString: link) { [weak self] (image, path) in
            
            let arrayAds = self?.ads.filter { ($0.image == path) }
            if (arrayAds?.count)! > 0 {
                self?.getUnicAdImage(link: link, compliteImage: compliteImage)
            } else {
                compliteImage(image, path)
            }
        }
    }
}
