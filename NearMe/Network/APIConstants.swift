//
//  APIConstants.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

struct APIConstants {
    static let clientKey = "AQOTGG0EHO4M5WFWG34JPZE4OO5QFSIRJEJKTBAKQGMAIZHL"
    // not so secret key for this demo
    static let clientSecret = "S0AHGVQAD5E1Q1D24O5B1R3DN3DA5NJZVPWS0NKKJCA0DKDM"
}

enum APIEndPoint: String {
    case recommendedVenues = "venues/explore"
    // case searchVenues = "venues/search"
    // case venueDetails = "venues/VENUE_ID"
    // etc.
    
    static var apiEngineHostUrl: String {
        // normally better to check for configuration whether DEBUG, Production, or some other
        // environment for server configs.
        return "https://api.foursquare.com/v2/"
    }
    
    var urlString: String {
        return APIEndPoint.apiEngineHostUrl + self.rawValue
    }
    
}

enum APIHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case httpError(Int)
    case timeout
    case notFound
    case badJson(String?)
    case unknown
    // add case as neeeded
}
