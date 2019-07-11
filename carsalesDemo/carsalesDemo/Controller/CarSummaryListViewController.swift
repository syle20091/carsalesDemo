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
        
        title = "Carsales Demo"
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
//MARK: UICollectionViewDataSource
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

//MARK: UICollectionViewDelegate
extension CarSummaryListViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.loadCarDetailViewController()
        vc.detailUrl = carLists[indexPath.row].DetailsUrl
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CarSummaryListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            if UIDevice.current.orientation.isLandscape {
                let columns = 3 as CGFloat
                let margings = 10 * (columns - 1) as CGFloat
                let width = (collectionView.frame.size.width - CGFloat(margings)) / columns
                let height = width
                return CGSize(width: width, height: height)
            }else{
                let columns = 2 as CGFloat
                let margings = 10 * (columns - 1) as CGFloat
                let width = (collectionView.frame.size.width - CGFloat(margings)) / columns
                let height = width
                return CGSize(width: width, height: height)
            }
        }
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}

