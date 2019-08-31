//
//  Product.swift
//  Combine6
//
//  Created by 이병찬 on 01/09/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    let imageURL: URL
}

extension Product: Codable {}
