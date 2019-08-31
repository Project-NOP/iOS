//
//  RootWindowState.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import FirebaseUI

enum RootWindowState {
    case signIn(SignInViewBindable)
    case main(MainViewModel)
    
    var asViewController: UIViewController {
        switch self {
        case .signIn(let viewModel):
            let authUI = FUIAuth.defaultAuthUI()!
            return SignInViewController(authUI: authUI).then {
                $0.bind(viewModel)
            }
        case .main(let viewModel):
            return MainViewController().then {
                $0.bind(viewModel)
            }
        }
    }
}
