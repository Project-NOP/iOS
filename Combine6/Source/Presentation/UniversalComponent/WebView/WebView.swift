//
//  WebView.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class WebView: WKWebView, WKScriptMessageHandler {
    let message = PublishSubject<WebMessageType>()
    let shouldBack = PublishSubject<Void>()
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "message":
            handleWebMessage(body: message.body as? [String: Any])
        case "back":
            shouldBack.onNext(Void())
        default:
            return
        }
    }
    
    private func handleWebMessage(body: [String: Any]?) {
        if let body = body, let message = WebMessageType.get(value: body) {
            self.message.onNext(message)
        }
    }
    
    init() {
        let configuration = WKWebViewConfiguration()
        super.init(frame: .zero, configuration: configuration)
        
        configuration.userContentController.add(self, name: "message")
        configuration.userContentController.add(self, name: "back")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
