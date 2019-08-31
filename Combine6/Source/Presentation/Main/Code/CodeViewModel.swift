//
//  CodeViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CodeViewModel: CodeViewBindable {
    let isScanning: Signal<Bool>
    let viewDidAppear = PublishRelay<Void>()
    let viewDidDisappear = PublishRelay<Void>()
    
    let present: Driver<Presentable>
    
    let popupViewModel = CodePopupViewModel()
    let scannedCode = PublishRelay<String>()
    
    init() {
        let currentCode = Observable
            .merge(
                popupViewModel.code,
                scannedCode.asObservable()
            )
        
        let selectedBrand = currentCode
//            여기에 바코드를 입력해주세요
//            .filter { $0 == "" }
            .map { _ in ProductDummy().ionTheFit }
        
        let alertViewModel = selectedBrand
            .map { CodeProductAlertViewModel(product: $0) }
            .share()
        
        let presentAlertView = alertViewModel
            .map(PresentableView.codeProductAlertView)
        
        let presentResultView = alertViewModel
            .flatMapLatest { $0.confirm }
            .map { PresentableView.placeholderView }
        
        self.present = Observable<PresentableView>
            .merge(presentAlertView, presentResultView)
            .map { $0.asPresentable }
            .asDriver(onErrorDriveWith: .empty())
        
        self.isScanning = Observable
            .merge(
                viewDidAppear.map { _ in true },
                viewDidDisappear.map { _ in false },
                alertViewModel.flatMapLatest { $0.viewDidDisappear }.map { _ in true }
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
