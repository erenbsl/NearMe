//
//  API.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

/// API protocol defines the module for accesing network layer.
protocol API {
    associatedtype ResponseType: Codable
    
    var path: String { get }
    var httpMethod: APIHTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: Dictionary<String, String> { get }
    var timeout: TimeInterval { get }
}

extension API {
    
    var defaultJSONHeader : [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var httpMethod: APIHTTPMethod {
        return .get
    }
    
    var headers: Dictionary<String, String> {
        return defaultJSONHeader
    }
    
    var defaultParameters: [String: String] {
        return ["client_id": APIConstants.clientKey,
                "client_secret": APIConstants.clientSecret,
                "v": APIConstants.version]
    }
}

protocol EmptyInitializable {
    init()
}

protocol APIRequestable {
    func sendRequest<T: API>(for api: T, completion: @escaping (Result<T.ResponseType, APIError>) -> Void)
}

protocol APIDataProvider {
    associatedtype APIClientType: APIRequestable
    var apiClient: APIClientType { get }
}
