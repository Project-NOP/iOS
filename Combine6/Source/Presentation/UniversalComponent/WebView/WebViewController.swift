//
//  WebViewController.swift
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

class WebViewController: ViewController<EmptyViewBindable> {
    let webView = WebView()
    
    func bind() {
        self.disposeBag = DisposeBag()
        
        webView.shouldBack
            .bind(onNext: { [weak self] _ in
                self?.back()
            })
            .disposed(by: disposeBag)
        
        webView.message
            .filterNil { $0.asPresent }
            .share(replay: 1)
            .bind(to: self.rx.present)
            .disposed(by: disposeBag)
        
        webView.message
            .filterNil { $0.asPush }
            .share(replay: 1)
            .bind(to: self.rx.push)
            .disposed(by: disposeBag)
    }
    
    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
    
    override func attribute() {
        self.do {
            $0.navigationController?.isNavigationBarHidden = true
            $0.bind()
        }
    }
    
    override func layout() {
        view.addSubviews(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
