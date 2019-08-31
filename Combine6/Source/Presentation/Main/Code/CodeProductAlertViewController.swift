//
//  CodeProductAlertViewController.swift
//  Combine6
//
//  Created by 이병찬 on 01/09/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CodeProductAlertViewModel: CodeProductAlertViewBindable {
    let product: Product
    let confirmButtonTapped = PublishRelay<Void>()
    let cancelButtonTapped = PublishRelay<Void>()
    
    let viewDidDisappear = PublishRelay<Void>()
    let dismiss: Signal<Void>
    let confirm: Observable<Void>
    
    init(product: Product) {
        self.product = product
        
        self.dismiss = Observable
            .merge(
                confirmButtonTapped.asObservable(),
                cancelButtonTapped.asObservable()
            )
            .asSignal(onErrorSignalWith: .empty())
        
        self.confirm = viewDidDisappear
            .withLatestFrom(confirmButtonTapped.asObservable())
    }
}

protocol CodeProductAlertViewBindable {
    var product: Product { get }
    var confirmButtonTapped: PublishRelay<Void> { get }
    var cancelButtonTapped: PublishRelay<Void> { get }
    
    var viewDidDisappear: PublishRelay<Void> { get }
    var dismiss: Signal<Void> { get }
}

class CodeProductAlertViewController: ViewController<CodeProductAlertViewBindable> {
    let contentView = UIView()
    let productImageView = UIImageView()
    let suggestionTitleLabel = UILabel()
    let suggestionDescriptionLabel = UILabel()
    let confirmButton = UIButton()
    let cancelButton = UIButton()
    
    override func bind(_ viewModel: CodeProductAlertViewBindable) {
        self.disposeBag = DisposeBag()
        
        productImageView.kf.setImage(with: viewModel.product.imageURL, placeholder: #imageLiteral(resourceName: "logo_splash"))
        
        viewModel.dismiss
            .emit(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        self.rx.viewDidDisappear
            .map { _ in Void() }
            .bind(to: viewModel.viewDidDisappear)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind(to: viewModel.confirmButtonTapped)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        }
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 28
        }
        
        suggestionTitleLabel.do {
            $0.text = "이건 어떨까요?"
            $0.font = .systemFont(ofSize: 26, weight: .bold)
        }
        
        suggestionDescriptionLabel.do {
            $0.text = """
            해당 제품과 유사한 대체품을 소개해드려요!
            한번 확인해보세요!
            """
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .gray185
        }
        
        confirmButton.do {
            $0.setTitle("확인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 30
        }
        
        cancelButton.do {
            $0.setTitle("취소", for: .normal)
            $0.setTitleColor(.gray64, for: .normal)
            $0.backgroundColor = .lightGray
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 30
        }
    }
    
    override func layout() {
        view.addSubview(contentView)
        contentView.addSubviews(productImageView, suggestionTitleLabel, suggestionDescriptionLabel, confirmButton, cancelButton)
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(354)
        }
        
        productImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.width.height.equalTo(224)
            $0.centerX.equalToSuperview()
        }
        
        suggestionTitleLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        suggestionDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(suggestionTitleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(suggestionDescriptionLabel.snp.bottom).offset(26)
            $0.left.equalToSuperview().offset(26)
            $0.right.equalTo(view.snp.centerX).offset(-7)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-26)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(suggestionDescriptionLabel.snp.bottom).offset(26)
            $0.left.equalTo(view.snp.centerX).offset(7)
            $0.right.equalToSuperview().offset(-26)
            $0.height.equalTo(60)
            $0.bottom.equalToSuperview().offset(-26)
        }
    }
    
    override func initialize() {
        self.modalPresentationStyle = .overCurrentContext
    }
}
