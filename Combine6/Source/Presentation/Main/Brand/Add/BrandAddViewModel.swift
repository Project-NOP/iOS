//
//  BrandAddViewModel.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BrandAddViewModel: BrandAddViewBindable {
    let viewDidLoad = PublishRelay<Void>()
    let searchKeyword = PublishRelay<String>()
    
    let brands: Driver<[Brand]>
    let selectedBrands = PublishRelay<[Brand]>()
    
    let confirmButtonTapped = PublishRelay<Void>()
    let dismiss: Signal<Void>
    
    init() {
        let brands = viewDidLoad
            .map { _ in BrandDummy().all }
            .share()
        
        self.brands = Observable<[Brand]>
            .combineLatest(brands, searchKeyword.startWith("")) { brands, keyword -> [Brand] in
                brands
            }
            .asDriver(onErrorDriveWith: .empty())
        
        self.dismiss = selectedBrands
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
}
