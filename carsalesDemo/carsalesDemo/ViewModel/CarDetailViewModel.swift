//
//  CarDetailViewModel.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

struct CarDetailViewModel {
    let Location: String
    let Price: String
    let SaleStatus: String
    let Comments: String
    let Photos: [String]
    
    init(carDetail: CarDetail?) {
        self.Location = carDetail?.Overview?.Location ?? ""
        self.Price = carDetail?.Overview?.Price ?? ""
        self.SaleStatus = carDetail?.SaleStatus ?? ""
        self.Comments = carDetail?.Comments ?? ""
        self.Photos = carDetail?.Overview?.Photos ?? []
    }
}
