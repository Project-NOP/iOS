//
//  AppDelegate.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var rootWindow: RootWindow!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        self.rootWindow = RootWindow().then {
            $0.bind(RootWindowViewModel())
        }
        rootWindow.makeKeyAndVisible()
        
        EventBus.shared.post(.applicationDidFinishLanching)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if setSignIn(url, options: options) {
            return true
        }
        return true
    }
    
    private func setSignIn(_ url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: options[.sourceApplication] as? String) ?? false
    }
}

