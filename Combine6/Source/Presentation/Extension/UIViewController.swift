//
//  UIViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

extension UIViewController {
    func back() {
        guard let naviagtionViewControllers = navigationController?.viewControllers else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        if naviagtionViewControllers.first === self {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func setLargeNavigationSetting() {
        navigationController?.navigationBar.do {
            $0.prefersLargeTitles = true
            $0.backgroundColor = .white
            $0.barTintColor = .white
            $0.tintColor = .black
            $0.shadowImage = UIImage()
            $0.isTranslucent = false
        }
    }
}
