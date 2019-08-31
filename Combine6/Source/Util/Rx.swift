//
//  Rx.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import RxSwift

extension ObservableType {
    func filterNil<V>(_ transform: @escaping (E) -> V?) -> Observable<V> {
        return map(transform).filter { $0 != nil }.map { $0! }
    }
}
