//
//  BrandListViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BrandListViewModel: BrandListViewBindable {
    let viewDidLoad = PublishRelay<Void>()
    let brands: Driver<[Brand]>
    
    let searchKeyword = PublishRelay<String>()
    let addButtonTapped = PublishRelay<Void>()
    
    let push: Driver<Pushable>
    
    init() {
        let brands = viewDidLoad
            .map { _ in BrandDummy().japan }
            .share()
        
        self.brands = Observable<[Brand]>
            .combineLatest(brands, searchKeyword.startWith("")) { brands, keyword -> [Brand] in
                brands
            }
            .asDriver(onErrorDriveWith: .empty())
        
        self.push = addButtonTapped
            .map { PushableView.brandAdd(BrandAddViewModel()) }
            .asDriver(onErrorDriveWith: .empty())
    }
}
