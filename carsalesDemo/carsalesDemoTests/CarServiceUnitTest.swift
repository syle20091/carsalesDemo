//
//  CarServiceUnitTest.swift
//  carsalesDemoTests
//
//  Created by syle on 18/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation
import XCTest
@testable import carsalesDemo

class CarServiceUnitTest: XCTestCase {
    var carService: CarService!
    
    override func setUp() {
        let mockSession = MockCarSummarySession()
        carService = CarService(session: mockSession)
    }
    
    func testFetchCarSummaries() {
        let mockSession = MockCarSummarySession()
        carService = CarService(session: mockSession)
        
        let exceptation = XCTestExpectation(description: "Fetch car summaries")
        
        carService.fetchCarSummaries { (carSummaries, error) in
            if error != nil {
                XCTFail()
            }else{
                XCTAssert(carSummaries?.first?.Id == "OAG-AD-17216859")
                XCTAssert(carSummaries?.count == 2)
                exceptation.fulfill()
            }
        }
        
        self.wait(for: [exceptation], timeout: 10.0)
    }
    
    
    func testFetchCarDetail() {
        let mockSession = MockCarDetailSession()
        carService = CarService(session: mockSession)
        
        let exceptation = XCTestExpectation(description: "Fetch car detail")
        
        carService.fetchCarDetail(detailUrl: "1") { (carDetail, error) in
            if error != nil {
                XCTFail()
            }else{
                XCTAssert(carDetail?.Overview?.Price == "$30,480")
                exceptation.fulfill()
            }
        }
        
        self.wait(for: [exceptation], timeout: 10.0)
    }
}
