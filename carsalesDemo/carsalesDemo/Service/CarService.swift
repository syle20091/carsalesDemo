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
    
    static let baseUrl = "https://app-car.carsalesnetwork.com.au"
    static let testCredential = "?username=test&password=2h7H53eXsQupXvkz"
    
    let jsonUrl = baseUrl + "/stock/car/test/v1/listing" + testCredential
    
    func fetchCarSummaries(completion: @escaping ([CarSummary]?, Error?) -> ()) {
        
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
}
