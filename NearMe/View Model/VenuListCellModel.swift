//
//  VenuListCellModel.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/22.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

struct VenuListCellModel {
    
    private enum Constant {
        static let iconSize = "64"
    }
    
    private let venue: Venue
    
    var title: String {
        return self.venue.name
    }
    
    var address: String {
        return self.venue.location.address ?? ""
    }
    
    /// Constructs the icon's url by combining prefix, a constant size factor and the suffix.
    var iconUrl: String? {
        guard let icon = venue.categories?.first?.icon else { return nil }
        return icon.prefix + Constant.iconSize + icon.suffix
    }
    
    var distanceText: String? {
        guard let distance = venue.location.distance else { return nil }
        return String(Int(distance)) + "m"
    }
    
    init(venue: Venue) {
        self.venue = venue
    }
}
