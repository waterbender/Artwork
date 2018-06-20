//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

