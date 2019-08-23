//
//  FilterViewModel.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/23.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

struct FilterViewModel {
    private var filter: Filter
    
    var keyword: String? {
        return filter.keyword
    }
    
    var radius: Float {
        return filter.radius
    }
    
    init(filter: Filter) {
        self.filter = filter
    }
    
    mutating func updateValues(keyword: String?, radius: Float) {
        filter.keyword = keyword
        filter.radius = radius
    }
}

struct Filter {
    var keyword: String?
    var radius: Float
}
