//
//  ImagesManager.swift
//  MVP Artwork
//
//  Created by Zhenia Pasko on 6/20/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit

class ImagesManager {
    
    let router = Router<ImagesApi>()
    static let environment : NetworkEnvironment = .standardEnvironment
    func downloadImage(urlString: String, complition: @escaping (_ image: UIImage?, _ filePath: String?)->()) {
        print("Download Started")
        
        router.request(.imageUrl(urlLink: urlString), completion: { (data, response, error) in
            
            if error != nil {
                return
            }
            
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? "")
            print("Download Finished")
            complition(UIImage(data: data), response?.url?.absoluteString)
        })
    }
}
