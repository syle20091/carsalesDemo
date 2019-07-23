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
    var carDetailViewModel: CarDetailViewModel = CarDetailViewModel(carDetail: CarDetail())
    var carService: CarService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Car Detail"
        carService = CarService()
        fetchData(detailUrl: detailUrl)
        view.setUpErrorBanner()
    }
    
    fileprivate func fetchData(detailUrl: String) {
        self.view.activityStartAnimating()
        carService.fetchCarDetail(detailUrl: detailUrl) {[weak self] (carDetail, err) in
            if let err = err {
                self?.view.errorBanner(show: true, error: err)
                print("Failed to fetch courses:", err)
                self?.view.activityStopAnimating()
                return
            }
            self?.view.errorBanner(show: false)
            self?.updateUI(carDetail: carDetail)
        }
    }
    
    func updateUI(carDetail: CarDetail?){
        self.view.activityStopAnimating()
        self.carDetailViewModel = CarDetailViewModel(carDetail: carDetail)
        self.locationLabel.text = self.carDetailViewModel.Location
        self.priceLabel.text = self.carDetailViewModel.Price
        self.saleStatusLabel.text = self.carDetailViewModel.SaleStatus
        self.commentTextView.text = self.carDetailViewModel.Comments
        self.collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

//MARK: UICollectionViewDataSource
extension CarDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carDetailViewModel.Photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : DetailCarImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCarImageCollectionViewCell", for: indexPath) as! DetailCarImageCollectionViewCell
        
        let url = carDetailViewModel.Photos[indexPath.row]
        cell.imageView.image = UIImage(named: "Default_Image_Thumbnail")
        
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
