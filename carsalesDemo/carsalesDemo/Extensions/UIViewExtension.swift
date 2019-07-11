//
//  UIViewExtension.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func activityStartAnimating() {
        let activityColor = UIColor.gray
        let backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = activityColor
        activityIndicator.tag = 222
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(activityIndicator)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(222){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
