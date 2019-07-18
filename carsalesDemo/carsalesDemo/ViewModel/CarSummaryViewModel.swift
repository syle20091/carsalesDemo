//
//  CarSummaryViewModel.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

//struct CarSummaryViewModel {
//    let Title: String
//    let Location: String
//    let Price: String
//    let MainPhoto: String
//    let DetailsUrl: String
//    
//    init(carSummary: CarSummary) {
//        self.Title = carSummary.Title ?? ""
//        self.Location = carSummary.Location ?? ""
//        self.Price = carSummary.Price ?? ""
//        self.MainPhoto = carSummary.MainPhoto ?? ""
//        self.DetailsUrl = carSummary.DetailsUrl ?? ""
//    }
//}

class CarSummariesViewModel {
    private var carSummaries: [CarSummary] = []
    private var carService: CarService!
    
    init(carService: CarService) {
        self.carService = carService
    }
    
    /// This function fetch car summaries.
    /// - Parameter completion: The completion handler to call when the load request is complete
    /// - Parameter error: possible error
    func fetchCarSummaries(completion: @escaping (_ error: Error?) -> ()){
        carService.fetchCarSummaries { (carSummaries, error) in
            if let error = error {
                completion(error)
            }else{
                if let carSummaries = carSummaries {
                    self.carSummaries = carSummaries
                }else{
                    print("carSummaries is nil")
                }
                completion(nil)
            }
        }
    }
    
    func getCarSummariesCount() -> Int {
        return carSummaries.count
    }
    
    func getCarSummary(with index: Int) -> CarSummary? {
        if carSummaries.indices.contains(index) {
            return carSummaries[index]
        }
        return nil
    }
    
    func getCarTitle(with index: Int) -> String? {
        if let carSummary = getCarSummary(with: index), let title = carSummary.Title {
            return title
        }
        return nil
    }
    
    func getCarLocation(with index: Int) -> String? {
        if let carSummary = getCarSummary(with: index), let location = carSummary.Location {
            return location
        }
        return nil
    }
    
    func getCarPrice(with index: Int) -> String? {
        if let carSummary = getCarSummary(with: index), let price = carSummary.Price {
            return price
        }
        return nil
    }
    
    func getCarMainPhoto(with index: Int) -> String? {
        if let carSummary = getCarSummary(with: index), let mainPhoto = carSummary.MainPhoto {
            return mainPhoto
        }
        return nil
    }
    
    func getCarDetailUrl(with index: Int) -> String? {
        if let carSummary = getCarSummary(with: index), let detailUrl = carSummary.DetailsUrl {
            return detailUrl
        }
        return nil
    }
    
}
