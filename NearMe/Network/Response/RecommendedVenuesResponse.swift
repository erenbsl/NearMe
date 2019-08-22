//
//  RecommendedVenuesResponse.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation
import CoreLocation

struct RecommendedVenuesResponse: Codable {
    
    // MARK: Group
    struct Group: Codable {
        let type: String
        let name: String
        let items: [Venue]
        
        enum RootCodingKeys: String, CodingKey {
            case type
            case name
            case items
        }
        
        enum ItemCodingKeys: String, CodingKey {
            case venue
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.type = try container.decode(String.self, forKey: .type)
            self.name = try container.decode(String.self, forKey: .name)
            
            let itemContainer = try container.nestedContainer(keyedBy: ItemCodingKeys.self, forKey: .items)
            self.items = try itemContainer.decode([Venue].self, forKey: .venue)
        }
    }
    
    
    // MARK: Properties
    let groups: [Group]
}
