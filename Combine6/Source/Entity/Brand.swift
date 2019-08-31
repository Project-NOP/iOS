//
//  Brand.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

struct Brand {
    let name: String
    let description: String
    let imageURL: URL
}

extension Brand: Codable {
    static var sample: Brand {
        return Brand(name: "애플", description: "전자제품", imageURL: URL(string: "https://")!)
    }
}

