//
//  API.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import Moya

protocol API: TargetType {
    var parameters: [String: Any] { get }
}

extension API {
    var baseURL: URL {
        return URL(string: "https://szd3pdl8gd.execute-api.ap-northeast-2.amazonaws.com/production")!
    }
    
    var sampleData: Data {
        return Data()
    }
}
