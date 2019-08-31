//
//  SignInViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import FirebaseUI

class SignInViewModel: NSObject, SignInViewBindable, FUIAuthDelegate {
    let disposeBag = DisposeBag()
    private let didSignedResult = PublishSubject<AuthDataResult>()
    
    override init() {
        super.init()
        
        FUIAuth.defaultAuthUI()?.delegate = self
        
        didSignedResult
            .map { $0.user }
            .map { result -> User in
                User(id: result.uid, name: result.displayName!, imageURL: result.photoURL!.absoluteString)
            }
            .bind(onNext: { token in
                UserHelper.shared.store(token)
                EventBus.shared.post(.switchCurrentRootState)
            })
            .disposed(by: disposeBag)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard let result = authDataResult else {
            return
        }
        didSignedResult.onNext(result)
    }
}
