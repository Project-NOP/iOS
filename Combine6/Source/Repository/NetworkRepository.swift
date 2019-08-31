//
//  NetworkRepository.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import Moya

class NetworkRepository<API: TargetType> {
    let provider = MoyaProvider<API>()
}
