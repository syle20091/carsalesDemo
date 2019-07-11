//
//  ArrayExtention.swift
//  carsalesDemo
//
//  Created by syle on 11/7/19.
//  Copyright © 2019 tom. All rights reserved.
//

import Foundation

extension Array {
    func item(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
