//
//  ViewController.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import UIKit
import Alamofire

class CarSummaryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
//    var carSummaryViewModels: [CarSummaryViewModel] = []
    
    var carSummariesViewModel: CarSummariesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Carsales Demo"
        setUpCollectionView()
        view.setUpErrorBanner()
        
        let carService = CarService()
        carSummariesViewModel = CarSummariesViewModel(carService: carService)
        fetchData()
    }
    
    func setUpCollectionView() {
        self.collectionView.register(UINib(nibName: "CarSummaryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CarSummaryCollectionViewCell")
    }
    
    func fetchData() {
        self.view.activityStartAnimating()
        carSummariesViewModel.fetchCarSummaries {[weak self] (error) in
            if let error = error {
                self?.view.errorBanner(show: true, error: error)
                print("Failed to fetch courses:",error.localizedDescription)
            }else{
                self?.view.errorBanner(show: false)
                self?.collectionView.reloadData()
            }
            self?.view.activityStopAnimating()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
//MARK: UICollectionViewDataSource
extension CarSummaryListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carSummariesViewModel.getCarSummariesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CarSummaryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarSummaryCollectionViewCell", for: indexPath) as! CarSummaryCollectionViewCell
        
        let index = indexPath.row
        
        cell.titleLabel.text = carSummariesViewModel.getCarTitle(with: index)
        cell.priceLabel.text = carSummariesViewModel.getCarPrice(with: index)
        cell.locationLabel.text = carSummariesViewModel.getCarLocation(with: index)
        
        let url = carSummariesViewModel.getCarMainPhoto(with: index) ?? ""
        Alamofire.request(url).responseData { response in
            if let image = response.result.value {
                cell.imageView.image = UIImage(data: image)
            }
        }
        
        return cell;
    }
    
}

//MARK: UICollectionViewDelegate
extension CarSummaryListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadCarDetailViewController()
        vc.detailUrl = carSummariesViewModel.getCarDetailUrl(with: indexPath.row) ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CarSummaryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let columns: CGFloat = UIDevice.current.orientation.isLandscape ? 3 : 2
            let margings = 10 * (columns - 1) as CGFloat
            let width = (collectionView.frame.size.width - CGFloat(margings)) / columns
            let height = width
            return CGSize(width: width, height: height)
        }
        //calculate safe area padding for iphone x
        let window = UIApplication.shared.keyWindow
        var width = UIScreen.main.bounds.width
        if let leftPadding = window?.safeAreaInsets.left, let rightPadding = window?.safeAreaInsets.right{
            width = UIScreen.main.bounds.width - leftPadding - rightPadding
        }
        if(UIDevice.current.orientation.isLandscape){
            return CGSize(width: width, height: width / 3 * 2 + 120)
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}

