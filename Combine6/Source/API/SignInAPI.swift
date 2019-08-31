//
//  SignInAPI.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import Moya

enum SignInAPI: API {
    case signInWithGoogle(user: User)
    case signInWithFacebook(user: User)
    case signInWithTwitter(user: User)
}

extension SignInAPI {
    var path: String {
        switch self {
        case .signInWithGoogle:
            return "/auth/google"
        case .signInWithFacebook:
            return "/auth/facebook"
        case .signInWithTwitter:
            return "/auth/twitter"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .signInWithGoogle(user):
            return user.dictionary ?? [:]
        default:
            return [:]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
}
