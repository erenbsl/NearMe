//
//  NearMeTests.swift
//  NearMeTests
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import XCTest
@testable import NearMe

class NearMeTests: XCTestCase {

    var venueViewModel: VenueListViewModel!
    var filterViewModel: FilterViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        venueViewModel = VenueListViewModel(dataProvider: VenuesDataProvider())
        filterViewModel = FilterViewModel(filter: Filter(keyword: "test", radius: 100))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testVenueViewModel() {
        var venuesResponse: Response<RecommendedVenuesResponse>
        let bundle = Bundle(for: NearMeTests.classForCoder())
        if let path = bundle.path(forResource: "Venues", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                venuesResponse = try JSONDecoder().decode(Response<RecommendedVenuesResponse>.self, from: data)
                venueViewModel.venues = venuesResponse.responseObject.groups.first?.items ?? []
                
                XCTAssertTrue(venueViewModel.numberOfVenues == 10)
                
                let cellModel = venueViewModel.cellModel(at: 5)
                XCTAssertNotNil(cellModel)
                XCTAssertNotNil(cellModel?.address)
                XCTAssertNotNil(cellModel?.iconUrl)
                XCTAssertNotNil(cellModel?.distanceText)
                XCTAssertNotNil(cellModel?.title)
                
                let cellModel2 = venueViewModel.cellModel(at: 11)
                XCTAssertNil(cellModel2)
            } catch let error {
                XCTFail("parse error: \(error.localizedDescription)")
            }
        } else {
            XCTFail("Invalid filename/path.")
        }
    }
    
    func testFilterViewModel() {
        XCTAssert(filterViewModel.keyword == "test")
        XCTAssert(filterViewModel.radius == 100)
        
        filterViewModel.updateValues(keyword: "test2", radius: 1000)
        XCTAssert(filterViewModel.keyword == "test2")
        XCTAssert(filterViewModel.radius == 1000)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
