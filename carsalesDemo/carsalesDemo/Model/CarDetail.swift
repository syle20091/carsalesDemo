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

struct CarDetailView {
    var Id: String?
    var SaleStatus: String?
    var Location: String?
    var Price: String?
    var Photos: [String]?
    var Comments: String?
}


extension CarDetailView: Decodable {
    enum CodingKeys: String, CodingKey {
        case Result
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resluts = try container.decode([CarDetail].self, forKey: .Result)
        
        guard let result = resluts.first else {
            return
        }
        
        Id = result.Id
        SaleStatus = result.SaleStatus
        Comments = result.Comments
        Location = result.Overview?.Location
        Price = result.Overview?.Price
        Photos = result.Overview?.Photos
    }
}
