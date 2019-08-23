//
//  VenueListViewModel.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/22.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation
import CoreLocation

class VenueListViewModel {
    
    private let dataProvider: VenuesDataProvider
    var venues: [Venue] = []
    var shouldLoadAgain: Bool = true
    var offset: Int = 0
    let limit = 30
    
    var filterViewModel: FilterViewModel {
        // create the default filter
        let filter = Filter(keyword: nil, radius: 1000)
        return FilterViewModel(filter: filter)
    }
    
    var numberOfVenues: Int {
        return venues.count
    }
    
    init(dataProvider: VenuesDataProvider) {
        self.dataProvider = dataProvider
    }
    
    
    /// Fetches the next set of venues and returns them in a completion handler.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates of the user.
    ///   - keyword: Keyword to enchance the search.
    ///   - radius: Radius of the search area
    ///   - completion: Completion block containing the new indexes if there is an addition, or the error message if there was an error.
    ///   - indexes: New set of indexes to be inserted into the list.
    ///   - errorMessage: Human readable text of the error.
    func loadVenues(near coordinates: CLLocationCoordinate2D, keyword: String? = nil, radius: Float, completion: @escaping (_ indexes: IndexSet?, _ errorMessage: String?) -> Void) {
        // since we got paging, only load if there is a next page
        guard shouldLoadAgain else { return }
        
        let option = RecommendedVenues.Option(keyword: keyword, radius: radius, offset: offset, limit: limit, coordinates: coordinates)
        dataProvider.loadVenues(option: option) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                completion(nil, error.localizedDescription)
            case .success(let response):
                guard response.meta.isSuccess else {
                    completion(nil, "Failed response code")
                    return
                }
                
                var oldCount = 0
                var newCount = 0
                oldCount = self.venues.count
                self.venues += response.responseObject.groups.first?.items ?? []
                newCount = self.venues.count
                
                // stop paging when total results are reached
                self.shouldLoadAgain = response.responseObject.totalResults > self.venues.count
                if response.responseObject.totalResults > self.venues.count {
                    self.offset = self.venues.count
                }
                
                completion(IndexSet(integersIn: oldCount..<newCount), nil)
            }
        }
    }
    
    func reset() {
        offset = 0
        shouldLoadAgain = true
        venues = []
    }
    
    /// Creates and returns the cell model needed for the cell at the given index. Returns nil if index is out of bounds.
    func cellModel(at index: Int) -> VenuListCellModel? {
        guard index >= 0, index < venues.count else { return nil }
        return VenuListCellModel(venue: venues[index])
    }
}
