//
//  SignInRepository.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class SignInRepository: NetworkRepository<SignInAPI> {
    func signInWithGoogle(user: User) -> Single<Token?> {
        return provider.rx
            .request(
                .signInWithGoogle(user: user)
            )
            .filterSuccessfulStatusCodes()
            .map(Token.self, atKeyPath: "data")
            .map { $0 as Token? }
            .catchErrorJustReturn(nil)
    }
}
