//
//  CarSummaryViewModel.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

struct CarSummaryViewModel {
    let Title: String
    let Location: String
    let Price: String
    let MainPhoto: String
    let DetailsUrl: String
    
    init(carSummary: CarSummary) {
        self.Title = carSummary.Title ?? ""
        self.Location = carSummary.Location ?? ""
        self.Price = carSummary.Price ?? ""
        self.MainPhoto = carSummary.MainPhoto ?? ""
        self.DetailsUrl = carSummary.DetailsUrl ?? ""
    }
}
