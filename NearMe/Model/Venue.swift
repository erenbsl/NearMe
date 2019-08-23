//
//  Venue.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

struct Venue: Codable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]?
    
    // MARK: Location
    struct Location: Codable {
        let address: String?
        let latitude: Double
        let longitude: Double
        let distance: Float?
        
        enum CodingKeys: String, CodingKey {
            case address
            case latitude = "lat"
            case longitude = "lng"
            case distance
        }
    }
    
    // MARK: Category
    struct Category: Codable {
        let id: String
        let name: String
        let icon: Icon
        
        struct Icon: Codable {
            let prefix: String
            let suffix: String
        }
    }
}
