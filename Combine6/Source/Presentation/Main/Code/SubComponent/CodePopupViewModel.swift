//
//  CodePopupViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CodePopupViewModel: CodePopupViewBindable {
    let currentModel: Signal<Mode>
    let modeChangeButtonTapped = PublishRelay<Void>()
    
    let code: Observable<String>
    let codeInput = PublishRelay<String>()
    let confirmButtonTapped = PublishRelay<Void>()
    
    init() {
        self.currentModel = modeChangeButtonTapped
            .scan(Mode.scan) { before, _ in
                (before == .input) ? .scan : .input
            }
            .startWith(.scan)
            .asSignal(onErrorSignalWith: .empty())
        
        self.code = confirmButtonTapped.withLatestFrom(codeInput)
    }
}
