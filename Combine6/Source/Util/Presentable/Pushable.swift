//
//  Pushable.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

protocol Pushable {
    var asViewController: UIViewController { get }
}

extension Pushable {
    var asPushable: Pushable {
        return self
    }
}

enum PushableView: Pushable {
    case web(URL, Bool)
    case brandList(BrandListViewBindable)
    case brandAdd(BrandAddViewBindable)
    
    var asViewController: UIViewController {
        switch self {
        case .web(let url, let showNavigation):
            return WebViewController().then {
                $0.load(url: url)
                $0.navigationController?.isNavigationBarHidden = !showNavigation
            }
        case .brandList(let viewModel):
            return BrandListViewController().then {
                $0.bind(viewModel)
            }
        case .brandAdd(let viewModel):
            return BrandAddViewController().then {
                $0.bind(viewModel)
            }
        }
    }
}
