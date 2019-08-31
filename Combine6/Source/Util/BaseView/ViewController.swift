//
//  ViewController.swift
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

class ViewController<VB>: UIViewController {
    var disposeBag = DisposeBag()
    
    func bind(_ viewModel: VB) {}
    
    func attribute() {}
    
    func layout() {}
    
    func initialize() {}
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.do {
            $0.view.backgroundColor = .white
        }
        
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

