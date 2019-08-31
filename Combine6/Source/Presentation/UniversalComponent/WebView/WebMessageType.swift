//
//  WebMessageType.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

enum WebMessageType {
    case presentWeb(URL, Bool), pushWeb(URL, Bool)
    case brandList
    
    static func get(value: [String: Any]) -> WebMessageType? {
        let view = value["view"]! as! String
        let present = value["present_type"]! as! String
        let url = value["url"] as? String
        let showNavigation = value["show_navigation"] as? Bool
        
        switch (view, present, url) {
        case ("web", "present", let url) where url != nil:
            return .presentWeb(URL(string: url!)!, showNavigation!)
        case ("web", "push", let url) where url != nil:
            return .pushWeb(URL(string: url!)!, showNavigation!)
        case ("brand_list", "present", _):
            return .brandList
        default:
            return nil
        }
    }
}

extension WebMessageType {
    var asPush: Pushable? {
        switch self {
        case .pushWeb(let url, let showNavigation):
            return PushableView.web(url, showNavigation)
        default:
            return nil
        }
    }
    
    var asPresent: Presentable? {
        switch self {
        case .presentWeb(let url, let showNavigation):
            return PresentableView.web(url, showNavigation)
        case .brandList:
            return PresentableView.brandList(BrandListViewModel())
        default:
            return nil
        }
    }
}
