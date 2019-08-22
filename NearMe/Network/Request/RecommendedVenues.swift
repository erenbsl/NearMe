//
//  RecommendedVenues.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation
import CoreLocation

struct RecommendedVenues: API {
    
    private enum PropertyKey {
        static let keyword = "query"
        static let page = "offset"
        static let limit = "limit"
        static let coordinates = "ll"
    }
    
    /// Encapsulated struct to keep the request parameters in place.
    struct Option {
        let keyword: String
        let page: Int
        let limit: Int
        let coordinates: CLLocationCoordinate2D
        
        init(keyword: String, page: Int = 0, limit: Int, coordinates: CLLocationCoordinate2D) {
            self.keyword = keyword
            self.page = page
            self.limit = limit
            self.coordinates = coordinates
        }
    }
    
    typealias ResponseType = Response<RecommendedVenuesResponse>
    var parameters = [String: Any]()
    var path: String = APIEndPoint.recommendedVenues.urlString
    
    private var option: Option
    
    init(with option: Option) {
        self.option = option
        prepareParameters()
    }
    
    private mutating func prepareParameters() {
        parameters[PropertyKey.keyword] = option.keyword
        parameters[PropertyKey.page] = option.page
        parameters[PropertyKey.limit] = option.limit
        parameters[PropertyKey.coordinates] = "\(option.coordinates.latitude),\(option.coordinates.longitude)"
    }
}
