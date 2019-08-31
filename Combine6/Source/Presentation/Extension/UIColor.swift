//
//  UIColor.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

extension UIColor {
    static let gray64 = UIColor(red: 64 / 255, green: 64 / 255, blue: 64 / 255, alpha: 1)
    static let gray185 = UIColor(red: 185 / 255, green: 185 / 255, blue: 185 / 255, alpha: 1)
    static let gray245 = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
    
    static let blue60 = UIColor(red: 60 / 255, green: 90 / 255, blue: 154 / 255, alpha: 1)
    static let blue93 = UIColor(red: 93 / 255, green: 168 / 255, blue: 220 / 255, alpha: 1)
    
    var asImage: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
