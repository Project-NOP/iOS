//
//  CodeViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import RxAppState
import RxKeyboard

protocol CodeViewBindable {
    var popupViewModel: CodePopupViewModel { get }
    var scannedCode: PublishRelay<String> { get }
    
    var isScanning: Signal<Bool> { get }
    var viewDidAppear: PublishRelay<Void> { get }
    var viewDidDisappear: PublishRelay<Void> { get }
    
    var present: Driver<Presentable> { get }
}

class CodeViewController: ViewController<CodeViewBindable> {
    let codeView = CodeView()
    let popupCoveredView = UIView()
    let popupView = CodePopupView()
    
    override func bind(_ viewModel: CodeViewBindable) {
        self.disposeBag = DisposeBag()
        
        popupView.bind(viewModel.popupViewModel)
        
        viewModel.present
            .drive(self.rx.present)
            .disposed(by: disposeBag)
        
        viewModel.isScanning
            .emit(onNext: { [weak self] isScanning in
                isScanning ? self?.codeView.start() : self?.codeView.stop()
            })
            .disposed(by: disposeBag)
        
        codeView.currentCode
            .throttle(1, scheduler: MainScheduler.instance)
            .do(onNext: { [weak codeView] _ in
                codeView?.stop()
            })
            .bind(to: viewModel.scannedCode)
            .disposed(by: disposeBag)
        
        self.rx.viewDidAppear
            .flatMapLatest { _ in
                RxKeyboard.instance.visibleHeight.asObservable()
            }
            .bind(to: self.rx.setKeyboardHeight)
            .disposed(by: disposeBag)
        
        self.rx.viewDidAppear.map { _ in Void() }
            .bind(to: viewModel.viewDidAppear)
            .disposed(by: disposeBag)
        
        self.rx.viewDidDisappear.map { _ in Void() }
            .bind(to: viewModel.viewDidDisappear)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        codeView.do {
            $0.initialize()
        }
        
        popupCoveredView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
        }
    }
    
    override func layout() {
        view.addSubviews(codeView, popupCoveredView, popupView)
        
        codeView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        popupView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
        
        popupCoveredView.snp.makeConstraints {
            $0.left.right.top.equalTo(popupView)
            $0.bottom.equalToSuperview()
        }
    }
}

extension Reactive where Base: CodeViewController {
    var setKeyboardHeight: Binder<CGFloat> {
        return Binder(base) { base, height in
            base.popupView.snp.updateConstraints {
                let bottomOffset = (height > 0) ? -height : -base.view.safeAreaInsets.bottom
                $0.bottom.equalToSuperview().offset(bottomOffset)
            }
            
            UIView.animate(withDuration: 0.3) {
                base.view.layoutIfNeeded()
            }
        }
    }
}
