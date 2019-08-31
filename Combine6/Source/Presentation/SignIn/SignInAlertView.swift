//
//  SignInAlertView.swift
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

import FirebaseUI

class SignInAlertView: View<EmptyViewBindable> {
    let authUI = FUIAuth.defaultAuthUI()!
    let googleProvider = FUIGoogleAuth()
    let facebookProvider = FUIFacebookAuth()
    lazy var twitterProvider = FUIOAuth(
        authUI: self.authUI, providerID: "twitter.com",
        buttonLabelText: "", shortName: "Twitter",
        buttonColor: .white, iconImage: UIImage(),
        scopes: ["user.readwrite"], customParameters: ["prompt" : "consent"], loginHintKey: nil
    )
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let googleButton = SocialAuthButton()
    let facebookButton = SocialAuthButton()
    let twitterButton = SocialAuthButton()
    let termLabel = UILabel()
    
    let contentView = UIView()
    let dimView = UIControl()
    
    private let downHeight: CGFloat = 700
    
    func present() {
        self.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.dimView.alpha = 1
            self.contentView.center.y = self.contentView.center.y - self.downHeight
        }
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dimView.alpha = 0
            self.contentView.center.y = self.contentView.center.y + self.downHeight
        }, completion: { _ in
            self.isHidden = true
        })
    }
    
    override func attribute() {
        self.do {
            $0.isHidden = true
        }
        
        dimView.do {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        }
        
        contentView.do {
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
        }
        
        titleLabel.do {
            $0.text = "시작해볼까요?"
            $0.font = .systemFont(ofSize: 24, weight: .heavy)
            $0.textAlignment = .center
        }
        
        descriptionLabel.do {
            $0.text = """
            환영합니다! 먼저, 원하시는 소셜 로그인을
            통해 서비스에 가입 절차를 진행해주세요.
            """
            $0.numberOfLines = 2
            $0.textColor = .gray185
            $0.font = .systemFont(ofSize: 18)
            $0.textAlignment = .center
        }
        
        termLabel.do {
            $0.text = "개인정보 수집 및 이용에 모두 동의합니다."
            $0.textColor = .gray185
            $0.font = .systemFont(ofSize: 14)
            $0.textAlignment = .center
        }
        
        googleButton.do {
            $0.titleLabel.text = "구글 계정으로 로그인"
            $0.titleLabel.textColor = .gray64
            $0.imageView.image = #imageLiteral(resourceName: "logo_google")
            $0.backgroundColor = .gray245
        }
        
        facebookButton.do {
            $0.titleLabel.text = "페이스북으로 로그인"
            $0.titleLabel.textColor = .white
            $0.imageView.image = #imageLiteral(resourceName: "logo_facebook")
            $0.backgroundColor = .blue60
        }
        
        twitterButton.do {
            $0.titleLabel.text = "트위터로 로그인"
            $0.titleLabel.textColor = .white
            $0.imageView.image = #imageLiteral(resourceName: "logo_twitter")
            $0.backgroundColor = .blue93
        }
    }
    
    override func layout() {
        addSubviews(dimView, contentView)
        contentView.addSubviews(titleLabel, descriptionLabel, googleButton, facebookButton, twitterButton, termLabel)
        
        contentView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(30)
        }
        
        googleButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(27)
            $0.height.equalTo(70)
        }
        
        facebookButton.snp.makeConstraints {
            $0.top.equalTo(googleButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(27)
            $0.height.equalTo(70)
        }
        
        twitterButton.snp.makeConstraints {
            $0.top.equalTo(facebookButton.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(27)
            $0.height.equalTo(70)
        }
        
        termLabel.snp.makeConstraints {
            $0.top.equalTo(twitterButton.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-37)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dimView.alpha = 0
        contentView.center.y = contentView.center.y + downHeight
    }
}

extension Reactive where Base: SignInAlertView {
    var selectedProvider: Observable<FUIAuthProvider> {
        base.dismiss()
        
        return Observable<FUIAuthProvider>
            .merge(
                base.googleButton.rx.tap.map { [unowned base] in base.googleProvider },
                base.facebookButton.rx.tap.map { [unowned base] in base.facebookProvider },
                base.twitterButton.rx.tap.map { [unowned base] in base.twitterProvider }
            )
    }
}
