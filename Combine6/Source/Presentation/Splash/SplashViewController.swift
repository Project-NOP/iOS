//
//  SplashViewController.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import Then
import SnapKit

class SplashViewController: ViewController<EmptyViewBindable> {
    let imageView = UIImageView()
    
    override func attribute() {
        self.do {
            $0.view.backgroundColor = .black
        }
        
        imageView.do {
            $0.image = #imageLiteral(resourceName: "logo_splash")
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func layout() {
        view.addSubviews(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(150)
        }
    }
}
