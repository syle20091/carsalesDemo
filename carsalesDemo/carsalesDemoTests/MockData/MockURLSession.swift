//
//  MockURLSession.swift
//  carsalesDemoTests
//
//  Created by syle on 18/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        print("mock resume")
    }
}

//Mock data session to test fetch carsummaries
class MockCarSummarySession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let jsonString =  """
{
  "Result": [
    {
      "Id": "OAG-AD-17216859",
      "Title": "2013 BMW 328i Sport Line F30 Auto MY14",
      "Location": "VIC",
      "Price": "$30,480",
      "MainPhoto": "https://carsales.li.csnstatic.com/car/dealer/bdtuvorf4cvft0nrun3xtt6e5.jpg",
      "DetailsUrl": "/stock/car/test/v1/details/OAG-AD-17216859"
    },
    {
      "Id": "OAG-AD-17185611",
      "Title": "2019 Mazda CX-5 Maxx Sport KF Series Auto FWD",
      "Location": "QLD",
      "Price": "$38,240",
      "MainPhoto": "https://carsales.li.csnstatic.com/car/dealer/8ebb9d883b5534eae81b3415d8544655.jpg",
      "DetailsUrl": "/stock/car/test/v1/details/OAG-AD-17185611"
    }]
}
"""
        let data = jsonString.data(using: .utf8)!
        completionHandler(data, nil, nil)
        
        return MockURLSessionDataTask()
    }
}

//Mock data session to test fetch car detail
class MockCarDetailSession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let jsonString =  """
{
  "Result": [
    {
      "Id": "OAG-AD-17216859",
      "SaleStatus": "For Sale",
      "Overview": {
        "Location": "Victoria",
        "Price": "$30,480",
        "Photos": [
          "https://carsales.li.csnstatic.com/car/dealer/skfk9npngtlvy1cuiq43p6ax9.jpg",
          "https://carsales.li.csnstatic.com/car/dealer/42e508fmmnygjp92czsvokur3.jpg"
        ]
      },
      "Comments": "EOFY"
    }
  ]
}
"""
        let data = jsonString.data(using: .utf8)!
        completionHandler(data, nil, nil)
        
        return MockURLSessionDataTask()
    }
}
