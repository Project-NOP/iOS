//
//  UIButton.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import SnapKit

extension UIButton {
    func coverSafeAreaBottom(_ superView: UIView) {
        let bottomCoveredView = UIView().then {
            self.addSubview($0)
            $0.tag = 1024
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(superView.safeAreaInsets.bottom)
        }
        
        bottomCoveredView.snp.makeConstraints {
            $0.top.equalTo(superView.safeAreaInsets.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(superView)
        }
    }
}
