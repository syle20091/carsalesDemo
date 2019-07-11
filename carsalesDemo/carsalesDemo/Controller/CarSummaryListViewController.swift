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
    }
}

extension CarSummaryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CarSummaryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarSummaryCollectionViewCell", for: indexPath) as! CarSummaryCollectionViewCell
                
        return cell;
    }
    
}

extension CarSummaryListViewController: UICollectionViewDelegate{
    
}

