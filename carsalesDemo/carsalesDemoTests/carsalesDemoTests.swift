//
//  carsalesDemoTests.swift
//  carsalesDemoTests
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import XCTest
@testable import carsalesDemo

class carsalesDemoTests: XCTestCase {

    var viewModel: CarSummariesViewModel!
    
    override func setUp() {
        let mockSession = MockCarSummarySession()
        let carService = CarService(session: mockSession)
        viewModel = CarSummariesViewModel(carService: carService)
        let exceptation = XCTestExpectation(description: "Fetch car summaries")
        
        viewModel.fetchCarSummaries { (error) in
                exceptation.fulfill()
        }
        
        self.wait(for: [exceptation], timeout: 10.0)
    }
    
    func testFetchCarSummaries() {
        let exceptation = XCTestExpectation(description: "Fetch car summaries")
        
        viewModel.fetchCarSummaries { (error) in
            if error == nil {
                XCTAssert(error == nil)
                exceptation.fulfill()
            }else{
                XCTFail()
            }
        }
        
        self.wait(for: [exceptation], timeout: 10.0)
    }

    func testGetCarSummariesCount() {
        XCTAssert(viewModel.getCarSummariesCount() == 2)
    }
    
    func testGetCarTitle() {
        XCTAssert(viewModel.getCarTitle(with: 0) == "2013 BMW 328i Sport Line F30 Auto MY14")
    }
    
    func testGetCarLocation() {
        XCTAssert(viewModel.getCarLocation(with: 0) == "VIC")
    }
    
    func testGetCarPrice() {
        XCTAssert(viewModel.getCarPrice(with: 0) == "$30,480")
    }
    
    func testGetCarMainPhoto() {
        XCTAssert(viewModel.getCarMainPhoto(with: 0) == "https://carsales.li.csnstatic.com/car/dealer/bdtuvorf4cvft0nrun3xtt6e5.jpg")
    }
    
    func testGetCarDetailUrl() {
        XCTAssert(viewModel.getCarDetailUrl(with: 0) == "/stock/car/test/v1/details/OAG-AD-17216859")
    }

    
    func testCarDetailViewModel() {
        let photos = ["1"]
        let carOverView = CarOverView(Location: "VIC", Price: "399", Photos: photos)
        let carDetail = CarDetail(Id: "id", SaleStatus: "sale", Overview: carOverView, Comments: "comment")
        let viewModel = CarDetailViewModel(carDetail: carDetail)
        
        XCTAssertTrue(viewModel.Comments == "comment")
        XCTAssertTrue(viewModel.Location == "VIC")
        XCTAssertTrue(viewModel.Price == "399")
        XCTAssertTrue(viewModel.SaleStatus == "sale")
        XCTAssertTrue(viewModel.Photos[0] == "1")
    } 

}
