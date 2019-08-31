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
            .map { code in
                Product(name: "제품", imageURL: URL(string: "https://")!)
            }
        
        let alertViewModel = selectedBrand
            .map { CodeProductAlertViewModel(product: $0) }
            .share()
        
        let presentResultView = alertViewModel
            .flatMapLatest { $0.confirm }
            .map { PresentableView.web(URL(string: "https://www.naver.com")!, true) }
        
        self.present = Observable<PresentableView>
            .merge(
                alertViewModel.map(PresentableView.codeProductAlertView),
                presentResultView
            )
            .map { $0.asPresentable }
            .asDriver(onErrorDriveWith: .empty())
        
    }
}
