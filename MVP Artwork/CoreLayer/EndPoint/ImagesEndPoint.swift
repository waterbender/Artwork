//
//  ArtworkEndPoint.swift
//  NetworkLayer
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import Foundation

enum ImagesDownloadEnvironment {
    case standardEnvironment
}

public enum ImagesApi {
    case imageUrl(urlLink: String)
}

extension ImagesApi: EndPointType {
    
    var environmentBaseURL : String {
        switch self {
        case .imageUrl(let urlLink): return urlLink
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .imageUrl(_):
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .imageUrl(urlLink: _):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [:])
//        default:
//            return .request_
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


