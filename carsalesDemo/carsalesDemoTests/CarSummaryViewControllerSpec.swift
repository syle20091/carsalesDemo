
//
//  CarSummaryViewController.swift
//  carsalesDemoTests
//
//  Created by syle on 19/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import carsalesDemo

class CarSummaryListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CarSummaryViewController"){
            var viewController: CarSummaryListViewController?
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: "CarSummaryListViewController") as? CarSummaryListViewController
                _ = viewController?.view
                
                viewController?.setUpCollectionView()
                let mockSession = MockCarSummarySession()
                let service = CarService(session: mockSession)
                let viewModel = CarSummariesViewModel(carService: service)
                viewController?.carSummariesViewModel = viewModel
            }
            
            it("should display 1 section if there is no data"){
                viewController?.collectionView.reloadData()
                viewController?.collectionView.layoutIfNeeded()
                
                let section = viewController?.collectionView.numberOfSections
                expect(section) == 1
            }
            
            it("should display 0 item if there is no data"){
                viewController?.collectionView.reloadData()
                viewController?.collectionView.layoutIfNeeded()
                
                let item = viewController?.collectionView.numberOfItems(inSection: 0)
                expect(item) == 0
            }
            
            it("should display 2 item after load mock data"){
                viewController?.fetchData()
                viewController?.collectionView.reloadData()
                viewController?.collectionView.layoutIfNeeded()

                waitUntil(timeout: 5) { done in
                    done()
                }

                let item = viewController?.collectionView.numberOfItems(inSection: 0)
                expect(item) == 2
            }
            
            it("should correctly display the title of first car after load mock data"){
                viewController?.fetchData()
                waitUntil(timeout: 5) { done in
                    done()
                }
                viewController?.collectionView.reloadData()
                viewController?.collectionView.layoutIfNeeded()
                let item = viewController?.collectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? CarSummaryCollectionViewCell
                expect(item?.titleLabel.text) == "2013 BMW 328i Sport Line F30 Auto MY14"
            }
        }
    }
}
