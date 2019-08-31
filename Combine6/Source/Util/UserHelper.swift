//
//  UserHelper.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

class UserHelper {
    private init() {}
    
    static let shared = UserHelper()
    
    func store(_ user: User) {
        guard let data = ParseHelper.shared.encode(user) else {
            return
        }
        UserDefaults.standard.set(data, forKey: "User")
    }
    
    func get() -> User? {
        guard let data = UserDefaults.standard.value(forKey: "User") as? Data else {
            return nil
        }
        return ParseHelper.shared.decode(User.self, data: data)
    }
}
