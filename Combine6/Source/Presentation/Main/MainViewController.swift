//
//  MainViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

struct MainViewModel {
    let codeViewModel = CodeViewModel()
}

class MainViewController: UITabBarController {
    var disposeBag = DisposeBag()
    
    let homeViewController = TodayViewController()
    let campaignViewController = CampaignViewController()
    let codeViewController = CodeViewController()
    let brandViewController = BrandViewController()
    let productViewController = ProductViewController()
    
    func bind(_ viewModel: MainViewModel) {
        codeViewController.bind(viewModel.codeViewModel)
    }
    
    func attribute() {
        self.do {
            $0.viewControllers = [
                UINavigationController(rootViewController: homeViewController),
                UINavigationController(rootViewController: campaignViewController),
                codeViewController,
                UINavigationController(rootViewController: brandViewController),
                UINavigationController(rootViewController: productViewController)
            ]
            $0.tabBar.barTintColor = .white
            $0.tabBar.shadowImage = UIImage()
            $0.tabBar.backgroundImage = UIImage()
            $0.tabBar.backgroundColor = .white
        }
        
        homeViewController.do {
            $0.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_navigation_home_white"), selectedImage: #imageLiteral(resourceName: "icon_navigation_home_black"))
        }
        
        campaignViewController.do {
            $0.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_navigation_campaign_white"), selectedImage: #imageLiteral(resourceName: "icon_navigation_campaign_black"))
        }
        
        codeViewController.do {
            $0.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_navigation_code_white"), selectedImage: #imageLiteral(resourceName: "icon_navigation_code_black"))
        }
        
        brandViewController.do {
            $0.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_navigation_brand_white"), selectedImage: #imageLiteral(resourceName: "icon_navigation_brand_black"))
        }
        
        productViewController.do {
            $0.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_navigation_product_white"), selectedImage: #imageLiteral(resourceName: "icon_navigation_product_black"))
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        selectedIndex = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
