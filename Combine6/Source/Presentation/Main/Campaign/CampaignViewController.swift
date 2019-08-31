//
//  CampaignViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CampaignViewController: ViewController<EmptyViewBindable> {
    let webView = WebView()
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    func bind() {
        self.disposeBag = DisposeBag()
        
        webView.message
            .filterNil { $0.asPush }
            .bind(to: self.rx.push)
            .disposed(by: disposeBag)
        
        webView.message
            .filterNil { $0.asPresent }
            .bind(to: self.rx.present)
            .disposed(by: disposeBag)
        
        webView.shouldBack
            .bind(onNext: { [weak self] _ in
                self?.back()
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.bind()
            $0.setLargeNavigationSetting()
            $0.navigationItem.title = "캠페인"
            $0.navigationItem.rightBarButtonItem = addButton
        }
        
        webView.do {
            let url = URL(string: "http://172.20.199.240:3000/campaign")!
            $0.load(URLRequest(url: url))
        }
    }
    
    override func layout() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaInsets)
            $0.left.right.equalToSuperview()
        }
    }
}
