//
//  RootWindowViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RootWindowViewModel: RootWindowBindable {
    let currentState: Driver<State>
    
    init() {
        self.currentState = Observable
            .merge(
                EventBus.shared.getEvent(.applicationDidFinishLanching),
                EventBus.shared.getEvent(.switchCurrentRootState)
            )
            .map { _ in
                if UserHelper.shared.get() != nil {
                    return State.main(MainViewModel())
                } else {
                    return State.signIn(SignInViewModel())
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
