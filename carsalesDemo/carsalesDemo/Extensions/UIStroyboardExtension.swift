//
//  UIStroyboardExtension.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import UIKit

fileprivate enum Storyboard : String {
    case main = "Main"
}

fileprivate extension UIStoryboard {
    
    static func loadFromMain(_ identifier: String) -> UIViewController {
        return load(from: .main, identifier: identifier)
    }
    
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

// MARK: App View Controllers

extension UIStoryboard {
    static func loadCarDetailViewController() -> CarDetailViewController {
        return loadFromMain("CarDetailViewController") as! CarDetailViewController
    }
}
