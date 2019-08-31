//
//  View.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class View<VB>: UIView {
    var disposeBag = DisposeBag()
    
    func bind(_ viewModel: VB) {}
    
    func attribute() {}
    
    func layout() {}
    
    convenience init(size: CGSize = .zero) {
        self.init(frame: CGRect(origin: .zero, size: size))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
