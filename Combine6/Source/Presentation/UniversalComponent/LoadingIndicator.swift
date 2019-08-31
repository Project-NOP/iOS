//
//  LoadingIndicator.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoadingIndicator: View<EmptyViewBindable> {
    fileprivate let indicator = UIActivityIndicatorView(style: .whiteLarge)
    
    func start() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
            self.indicator.startAnimating()
        }
    }
    
    func stop() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
            self.indicator.stopAnimating()
        }
    }
    
    override func attribute() {
        self.do {
            $0.backgroundColor = UIColor.gray185.withAlphaComponent(0.5)
            $0.layer.cornerRadius = 10
            $0.alpha = 0
        }
    }
    
    override func layout() {
        addSubviews(indicator)
        
        self.snp.makeConstraints {
            $0.width.height.equalTo(150)
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension Reactive where Base: LoadingIndicator {
    var isAnimating: Binder<Bool> {
        return Binder(base) { base, isAnimating in
            isAnimating ? base.start() : base.stop()
        }
    }
}
