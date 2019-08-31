//
//  Presentable.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    func present(_ presentable: Presentable) {
        self.present(
            presentable.asViewController, animated: true, completion: nil
        )
    }
    
    func push(_ pushable: Pushable) {
        self.navigationController?.pushViewController(
            pushable.asViewController, animated: true
        )
    }
}

extension Reactive where Base: UIViewController {
    var present: Binder<Presentable> {
        return Binder(base) { base, presentable in
            base.present(presentable)
        }
    }
    
    var push: Binder<Pushable> {
        return Binder(base) { base, pushable in
            base.push(pushable)
        }
    }
}
