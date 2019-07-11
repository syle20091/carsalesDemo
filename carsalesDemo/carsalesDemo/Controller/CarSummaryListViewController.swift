//
//  ViewController.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import UIKit

class CarSummaryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var carLists: [CarSummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Car Detail"
        setUpCollectionView()
        fetchData()
    }
    
    func setUpCollectionView() {
        self.collectionView.register(UINib(nibName: "CarSummaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarSummaryCollectionViewCell")
    }
    
    fileprivate func fetchData() {
        CarService.shared.fetchCarSummaries { (carSummaries, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            self.carLists = carSummaries ?? []
            self.collectionView.reloadData()
        }
    }
}

extension CarSummaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CarSummaryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarSummaryCollectionViewCell", for: indexPath) as! CarSummaryCollectionViewCell
        
        let car = self.carLists[indexPath.row]
        cell.carSummary = car
        
        return cell;
    }
    
}

extension CarSummaryListViewController: UICollectionViewDelegate{
    
}

extension CarSummaryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}

