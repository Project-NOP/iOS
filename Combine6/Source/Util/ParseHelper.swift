//
//  ParseHelper.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

class ParseHelper {
    private init() {}
    
    static let shared = ParseHelper()
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    func encode<E: Encodable>(_ value: E) -> Data? {
        return try? encoder.encode(value)
    }
    
    func decode<D: Decodable>(_ type: D.Type, data: Data) -> D? {
        return try? decoder.decode(type, from: data)
    }
}
