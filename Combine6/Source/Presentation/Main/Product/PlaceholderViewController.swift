//
//  PlaceholderViewController.swift
//  Combine6
//
//  Created by 이병찬 on 01/09/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaceholderViewController: ViewController<EmptyViewBindable> {
    let webView = WebView()
    let closeButton = UIBarButtonItem(title: "닫기", style: .plain, target: nil, action: nil)
    
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
        
        Observable
            .merge(
                webView.shouldBack,
                closeButton.rx.tap.asObservable()
            )
            .bind(onNext: { [weak self] _ in
                self?.back()
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.bind()
            $0.setLargeNavigationSetting()
            $0.navigationItem.title = "대체상품 추천"
            $0.navigationItem.rightBarButtonItem = closeButton
        }
        
        webView.do {
            let url = URL(string: "http://planbnb-deploy-s3.s3-website.ap-northeast-2.amazonaws.com/placeholder")!
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
