//
//  CALayer+ApplyShadow.swift
//  akshubnikovPW2
//
//  Created by Andrew Shubnikov on 29.09.2022.
//

import UIKit

public extension CALayer {
    func applyShadow() {
        masksToBounds = false
        shadowColor  = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        shadowOpacity = 1
        shadowOffset = CGSize(width: 2, height: 2)
        shadowRadius = 10
    }
}
