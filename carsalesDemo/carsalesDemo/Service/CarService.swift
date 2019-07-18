//
//  CarService.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

class CarService {
    static let shared = CarService()
    
    private let baseUrl = "https://app-car.carsalesnetwork.com.au"
    private let testCredential = "?username=test&password=2h7H53eXsQupXvkz"
    
    func fetchCarSummaries(completion: @escaping ([CarSummary]?, Error?) -> ()) {
        let jsonUrl = baseUrl + "/stock/car/test/v1/listing" + testCredential
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch carSummaries:", err)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let carlistsJson = try JSONDecoder().decode(CarList.self, from: data)
                
                let carSummaries = carlistsJson.Result ?? []
                
                DispatchQueue.main.async {
                    completion(carSummaries, nil)
                }
                
            }catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }
    
    func fetchCarDetail(detailUrl: String, completion: @escaping (CarDetail? , Error?) -> ()) {
        guard let url = URL(string: baseUrl + detailUrl + testCredential) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch CarDetail:", err)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let carlistsJson = try JSONDecoder().decode(CarDetailResult.self, from: data)
                
                if let result = carlistsJson.Result {
                    if let carDetail = result.item(at: 0) {
                        DispatchQueue.main.async {
                            completion(carDetail, nil)
                        }
                    }
                }
                
            }catch let jsonErr{
                print(jsonErr)
            }
        }.resume()
    }
}
