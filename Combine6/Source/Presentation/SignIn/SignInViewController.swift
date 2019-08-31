//
//  SignInViewController.swift
//  Combine6
//
//  Created by 이병찬 on 30/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then

import FirebaseUI

protocol SignInViewBindable {
    
}

class SignInViewController: FUIAuthPickerViewController {
    var disposeBag = DisposeBag()
    
    let imageView = UIImageView()
    let startButton = UIButton()
    let signInAlert = SignInAlertView()
    
    func bind(_ viewModel: SignInViewBindable) {
        self.disposeBag = DisposeBag()
        
        startButton.rx.tap
            .bind(onNext: { [weak signInAlert] in
                signInAlert?.present()
            })
            .disposed(by: disposeBag)
        
        signInAlert.dimView.rx.controlEvent(.touchUpInside)
            .bind(onNext: { [weak signInAlert] in
                signInAlert?.dismiss()
            })
            .disposed(by: disposeBag)
        
        signInAlert.rx.selectedProvider
            .bind(onNext: { [unowned self] provider in
                self.authUI.signIn(withProviderUI: provider, presenting: self, defaultValue: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func attribute() {
        imageView.do {
            $0.image = #imageLiteral(resourceName: "logo_splash")
            $0.contentMode = .scaleAspectFit
        }
        
        startButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .white
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("시작하기", for: .normal)
            $0.layer.cornerRadius = 30
            $0.alpha = 0
        }
    }
    
    func layout() {
        view.addSubviews(imageView, startButton, signInAlert)
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(150)
            $0.center.equalToSuperview()
        }
        
        startButton.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().offset(-60)
            $0.height.equalTo(60)
        }
        
        signInAlert.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func animate() {
        imageView.snp.updateConstraints {
            $0.width.height.equalTo(145)
            $0.centerY.equalToSuperview().offset(-40)
        }
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
            self.startButton.alpha = 1
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, authUI: FUIAuth) {
        super.init(nibName: nil, bundle: nil, authUI: authUI)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


