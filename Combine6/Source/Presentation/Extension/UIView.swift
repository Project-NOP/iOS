//
//  UIView.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addBorder(_ color: UIColor, width: CGFloat, edges: UIRectEdge...) {
        let layers = edges.compactMap { edge -> CALayer? in
            switch edge {
            case .top:
                return CALayer().then { $0.frame = CGRect(x: 0, y: 0, width: frame.width, height: width) }
            case .bottom:
                return CALayer().then { $0.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width) }
            case .left:
                return CALayer().then { $0.frame = CGRect(x: 0, y: 0, width: width, height: frame.height) }
            case .right:
                return CALayer().then { $0.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height) }
            default:
                return nil
            }
        }
        
        layers.forEach { self.layer.addSublayer($0) }
    }
}
