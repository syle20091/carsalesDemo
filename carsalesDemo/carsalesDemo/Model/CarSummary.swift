//
//  CarSummary.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

struct CarSummary: Decodable {
    
    var Id: String?
    var Title: String?
    var Location: String?
    var Price: String?
    var MainPhoto: String?
    var DetailsUrl: String?
    
}

struct CarList: Decodable {
    var Result: [CarSummary]?
}
