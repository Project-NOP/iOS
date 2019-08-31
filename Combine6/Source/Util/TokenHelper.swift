//
//  TokenHelper.swift
//  Combine6
//
//  Created by 이병찬 on 01/09/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

struct TokenHelper {
    static let shared = TokenHelper()
    
    private init() {}
    
    func store(token: Token) {
        guard let data = ParseHelper.shared.encode(token) else {
            return
        }
        UserDefaults.standard.set(data, forKey: "Token")
    }
    
    func get() -> Token? {
        guard let data = UserDefaults.standard.value(forKey: "Token") as? Data else {
            return nil
        }
        return ParseHelper.shared.decode(Token.self, data: data)
    }
}
