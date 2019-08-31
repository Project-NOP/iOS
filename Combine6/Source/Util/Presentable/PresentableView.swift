//
//  PresentableView.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

protocol Presentable {
    var asViewController: UIViewController { get }
}

extension Presentable {
    var asPresentable: Presentable {
        return self
    }
}

enum PresentableView: Presentable {
    case web(URL, Bool)
    case brandList(BrandListViewBindable)
    case codeProductAlertView(CodeProductAlertViewBindable)
    
    var asViewController: UIViewController {
        switch self {
        case .web(let url, let showNavigation):
            let viewController = WebViewController().then {
                $0.load(url: url)
            }
            return UINavigationController(rootViewController: viewController).then {
                $0.isNavigationBarHidden = !showNavigation
            }
        case .brandList(let viewModel):
            let viewController = BrandListViewController().then {
                $0.bind(viewModel)
            }
            return UINavigationController(rootViewController: viewController)
        case .codeProductAlertView(let viewModel):
            return CodeProductAlertViewController().then {
                $0.bind(viewModel)
            }
        }
    }
}
