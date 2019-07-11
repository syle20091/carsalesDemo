//
//  CarSummaryCollectionViewCell.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import UIKit
import Alamofire

class CarSummaryCollectionViewCell: UICollectionViewCell {

    var carSummaryViewModel: CarSummaryViewModel! {
        didSet{
            titleLabel.text = carSummaryViewModel.Title
            priceLabel.text = carSummaryViewModel.Price
            locationLabel.text = carSummaryViewModel.Location
            Alamofire.request(carSummaryViewModel.MainPhoto).responseData { response in
                
                if let image = response.result.value {
                    self.imageView.image = UIImage(data: image)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
}
