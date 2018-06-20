//
//  Artwork.swift
//  MVP Colors
//
//  Created by Zhenia Pasko on 6/20/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit


class ArtworksDataResponse: Decodable {
    let data: ArtworksApiResponse
    
    private enum ArtworksApiDataResponseCodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArtworksApiDataResponseCodingKeys.self)
        data = try container.decode(ArtworksApiResponse.self, forKey: .data)
    }
}

class ArtworksApiResponse: Decodable {
    let artworks: [Artwork]
    
    private enum ArtworksApiResponseCodingKeys: String, CodingKey {
        case artworks = "artworks"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ArtworksApiResponseCodingKeys.self)
        artworks = try container.decode([Artwork].self, forKey: .artworks)
   
    }
}

class Artwork: Decodable {
    let id: String
    let image: String
    var imageUI: UIImage?
    
    private enum ArtworkCodingKeys: String, CodingKey {
        case id
        case imageUrlString = "image"
    }
    
    required init(from decoder: Decoder) throws {
        let artworkContainer = try decoder.container(keyedBy: ArtworkCodingKeys.self)
        
        id = try artworkContainer.decode(String.self, forKey: .id)
        image = try artworkContainer.decode(String.self, forKey: .imageUrlString)
    }
}
