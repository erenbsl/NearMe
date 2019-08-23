//
//  VenuesDataProvider.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import Foundation

struct VenuesDataProvider: APIDataProvider {
    var apiClient: APIClient = APIClient()
    typealias APIClientType = APIClient
    
    typealias VenuesCompletionHandler = (Result<Response<RecommendedVenuesResponse>, APIError>) -> Void
    
    func loadVenues(option: RecommendedVenues.Option, completion: @escaping VenuesCompletionHandler) {
        let api = RecommendedVenues(with: option)
        
        apiClient.sendRequest(for: api, completion: completion)
    }
}
