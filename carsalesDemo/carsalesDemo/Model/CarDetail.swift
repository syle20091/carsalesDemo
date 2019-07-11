//
//  CarDetail.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

struct CarDetail: Decodable {
    
    var Id: String?
    var SaleStatus: String?
    var Overview: CarOverView?
    var Comments: String?
    
}

struct CarOverView: Decodable {
    var Location: String?
    var Price: String?
    var Photos: [String]?
}

struct CarDetailResult: Decodable {
    var Result: [CarDetail]?
}
