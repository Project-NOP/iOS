//
//  SocialAuthButton.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class SocialAuthButton: View<EmptyViewBindable> {
    let coveredButton = UIButton()
    let titleLabel = UILabel()
    let imageView = UIImageView()
    
    override func layout() {
        addSubviews(titleLabel, imageView, coveredButton)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
        }
        
        coveredButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func attribute() {
        self.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 35
        }
    }
}

extension Reactive where Base: SocialAuthButton {
    var tap: Observable<Void> {
        return base.coveredButton.rx.tap.asObservable()
    }
}
