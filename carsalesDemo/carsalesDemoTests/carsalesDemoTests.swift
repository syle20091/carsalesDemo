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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testCarsummaryViewModel() {
        let carsummary = CarSummary(Id: "id", Title: "title", Location: "location", Price: "price", MainPhoto: "photo", DetailsUrl: "url")
        let viewModel = CarSummaryViewModel(carSummary: carsummary)
        
        XCTAssertTrue(viewModel.Title == "title")
        XCTAssertTrue(viewModel.Location == "location")
        XCTAssertTrue(viewModel.Price == "price")
        XCTAssertTrue(viewModel.MainPhoto == "photo")
        XCTAssertTrue(viewModel.DetailsUrl == "url")
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
