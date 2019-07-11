//
//  CarDetailViewController.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CarDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var saleStatusLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    var detailUrl: String!
    var carDetail: CarDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Car Detail"
        fetchData(detailUrl: detailUrl)
    }
    
    fileprivate func fetchData(detailUrl: String) {
        CarService.shared.fetchCarDetail(detailUrl: detailUrl) { (carDetail, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            
            self.carDetail = carDetail
            self.locationLabel.text = self.carDetail?.Overview?.Location
            self.priceLabel.text = self.carDetail?.Overview?.Price
            self.saleStatusLabel.text = self.carDetail?.SaleStatus
            self.commentTextView.text = self.carDetail?.Comments
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//MARK: UICollectionViewDataSource
extension CarDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carDetail?.Overview?.Photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DetailCarImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCarImageCollectionViewCell", for: indexPath) as! DetailCarImageCollectionViewCell
        
        guard let url = carDetail?.Overview?.Photos?[indexPath.row] else {
            return cell
        }
        
        Alamofire.request(url).responseData { response in
            
            if let image = response.result.value {
                cell.imageView.image = UIImage(data: image)
            }
        }
        
        return cell;
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CarDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 2/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
