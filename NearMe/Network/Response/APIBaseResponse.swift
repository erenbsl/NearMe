//
//  APIBaseResponse.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

/// Generic struct to contain the common response part and the changing `response` object together.
struct Response<T: Codable>: Codable {
    var meta: APIResponseMeta
    var responseObject: T
    
    enum CodingKeys: String, CodingKey {
        case meta
        case responseObject = "response"
    }
}

/// Common response part existing in all the response objects.
struct APIResponseMeta: Codable {
    let code: Int
    let requestId: String
}
