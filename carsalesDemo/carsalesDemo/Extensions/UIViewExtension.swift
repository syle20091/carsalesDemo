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
    
    ///Call this function before show error banner
    func setUpErrorBanner() {
        let bounds = UIScreen.main.bounds
        let label = UILabel(frame: CGRect(x: 0, y: bounds.height - 48, width: bounds.width, height: 48))
        label.text = "OFFLINE"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .red
        label.isHidden = false
        label.alpha = 0
        label.tag = 89999
        self.addSubview(label)
    }
    
    ///Call this to show error banner
    ///- Warning: Call setUpErrorBanner() before call this function
    /// - Parameter show: bool to determine show or hide the banner
    /// - Parameter error: error for display
    func errorBanner(show: Bool, error: Error? = nil) {
        guard let label = self.viewWithTag(89999) as? UILabel else {
            return
        }
        
        if show && label.alpha == 1 {return}
        if !show && label.alpha == 0 {return}
        
        label.text = error?.localizedDescription ?? "something went wrong"
        
        UIView.animate(withDuration: 0.9, animations: {
            label.alpha = show ? 1 : 0
        })
    }
}
