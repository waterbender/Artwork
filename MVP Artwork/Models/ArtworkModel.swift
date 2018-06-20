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
    let networkLayer: NetworkManager
    
    init(with networkLayer: NetworkManager) {
        self.networkLayer = networkLayer
    }
    
    func getArtworks(completion: @escaping ArtworkCollectionPresenter.UpdateArtworksComplSucsess, limit: Int, page: Int) {
        networkLayer.getNewArtworks(limit: limit, page: page, completion: { [weak self] artworks, error in
            
            guard let artworks = artworks else {
                completion(false)
                return
            }
            self?.artworks.append(contentsOf: artworks)
            completion(true)
        })
    }
}
