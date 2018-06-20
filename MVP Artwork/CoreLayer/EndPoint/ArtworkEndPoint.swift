//
//  ArtworkEndPoint.swift
//  NetworkLayer
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case standardEnvironment
}

public enum ArtworkApi {
    case artworks(limit:Int, skip:Int)
}

extension ArtworkApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .standardEnvironment: return "https://demo4185666.mockable.io"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .artworks(_,_):
            return "get_artworks"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .artworks(let limit, let skip):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["limit":limit, "skip":skip])
//        default:
//            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


