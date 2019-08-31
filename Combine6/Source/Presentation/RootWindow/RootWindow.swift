//
//  RootWindow.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RootWindowBindable {
    typealias State = RootWindowState
    
    var currentState: Driver<State> { get }
}

class RootWindow: UIWindow {
    var disposeBag = DisposeBag()
    var viewModel: RootWindowBindable?
    
    func bind(_ viewModel: RootWindowBindable) {
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel
        
        viewModel.currentState
            .drive(onNext: { [weak self] state in
                self?.rootViewController = state.asViewController
            })
            .disposed(by: disposeBag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rootViewController = SplashViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
