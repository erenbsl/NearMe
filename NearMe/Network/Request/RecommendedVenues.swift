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
        static let radius = "radius"
        static let offset = "offset"
        static let limit = "limit"
        static let coordinates = "ll"
    }
    
    /// Encapsulated struct to keep the request parameters in place.
    struct Option {
        let keyword: String?
        let radius: Float
        let offset: Int
        let limit: Int
        let coordinates: CLLocationCoordinate2D
        
        init(keyword: String?, radius: Float, offset: Int, limit: Int, coordinates: CLLocationCoordinate2D) {
            self.keyword = keyword
            self.radius = radius
            self.offset = offset
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
        parameters[PropertyKey.radius] = option.radius
        parameters[PropertyKey.offset] = option.offset
        parameters[PropertyKey.limit] = option.limit
        parameters[PropertyKey.coordinates] = "\(option.coordinates.latitude),\(option.coordinates.longitude)"
    }
}
