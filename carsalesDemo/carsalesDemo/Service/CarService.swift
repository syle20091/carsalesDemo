//
//  CarService.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

class CarService {
    
    private let baseUrl = "https://app-car.carsalesnetwork.com.au"
    private let testCredential = "?username=test&password=2h7H53eXsQupXvkz"
    
    private var session: URLSession!
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchCarSummaries(completion: @escaping ([CarSummary]?, Error?) -> ()) {
        let jsonUrl = baseUrl + "/stock/car/test/v1/listing" + testCredential
        guard let url = URL(string: jsonUrl) else { return }
        print(jsonUrl)
        session.dataTask(with: url) { (data, response, err) in
            if let err = err {
                completion(nil, err)
                print("Failed to fetch carSummaries:", err)
                return
            }
            guard let data = data else {return}
            
            do{
                let carlistsJson = try JSONDecoder().decode(CarList.self, from: data)
                let carSummaries = carlistsJson.Result ?? []
                completion(carSummaries, nil)
                
            }catch let jsonErr {
                completion(nil, jsonErr)
                print(jsonErr)
            }
        }.resume()
    }
    
    func fetchCarDetail(detailUrl: String, completion: @escaping (CarDetail? , Error?) -> ()) {
        guard let url = URL(string: baseUrl + detailUrl + testCredential) else {return}
        
        session.dataTask(with: url) { (data, response, err) in
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
                        completion(carDetail, nil)
                    }
                }
            }catch let jsonErr{
                completion(nil, jsonErr)
                print(jsonErr)
            }
        }.resume()
    }
}

protocol NetWorkRequest {
    associatedtype Model
    func requestModel(withUrl url:String, _ completion: @escaping (Model?, Error?)-> Void)
    func requestList(withUrl url:String, _ completion: @escaping ([Model]?, Error?)-> Void)
}

extension NetWorkRequest {
    func requestModel(withUrl url:String, _ completion: @escaping (Model?, Error?)-> Void){
        
    }

}
