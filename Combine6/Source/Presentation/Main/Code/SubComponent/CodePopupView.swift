//
//  CodePopupView.swift
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

protocol CodePopupViewBindable {
    typealias Mode = CodePopupView.Mode
    
    var currentModel: Signal<Mode> { get }
    var modeChangeButtonTapped: PublishRelay<Void> { get }
    
    var codeInput: PublishRelay<String> { get }
    var confirmButtonTapped: PublishRelay<Void> { get }
}

class CodePopupView: View<CodePopupViewBindable> {
    enum Mode {
        case scan, input
    }
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let modeChangeButton = UIButton()
    
    let codeNoticeImageView = UIImageView()
    let codeNoticeLabel = UILabel()
    let codeTextField = UITextField()
    let underline = UIView()
    
    let confirmButton = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
    
    override func bind(_ viewModel: CodePopupViewBindable) {
        self.disposeBag = DisposeBag()
        
        viewModel.currentModel
            .emit(to: self.rx.switchMode)
            .disposed(by: disposeBag)
        
        modeChangeButton.rx.tap
            .bind(to: viewModel.modeChangeButtonTapped)
            .disposed(by: disposeBag)
        
        codeTextField.rx.text
            .filterNil { $0 }
            .bind(to: viewModel.codeInput)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind(to: viewModel.confirmButtonTapped)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind(onNext: { [weak codeTextField] _ in
                _ = codeTextField?.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 30, weight: .bold)
        }
        
        descriptionLabel.do {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .gray185
        }
        
        modeChangeButton.do {
            $0.titleLabel?.font = .systemFont(ofSize: 14)
            $0.setTitleColor(.black, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.cornerRadius = 6
        }
        
        codeTextField.do {
            $0.placeholder = "바코드 번호를 입력하세요"
            $0.font = .systemFont(ofSize: 24)
            $0.keyboardType = .numberPad
            $0.inputAccessoryView = confirmButton
            $0.clearButtonMode = .always
        }
        
        underline.do {
            $0.backgroundColor = .black
        }
        
        codeNoticeImageView.do {
            $0.image = #imageLiteral(resourceName: "icon_notice_gray")
            $0.contentMode = .scaleAspectFit
        }
        
        codeNoticeLabel.do {
            $0.text = "상품에 적혀있는 바코드를 직접 입력해주세요"
            $0.textColor = .gray185
        }
        
        confirmButton.do {
            $0.backgroundColor = .black
            $0.setTitle("확인", for: .normal)
            $0.backgroundColor = .black
            $0.setTitleColor(.white, for: .normal)
        }
    }
    
    override func layout() {
        addSubviews(titleLabel, descriptionLabel, modeChangeButton, codeNoticeImageView, codeNoticeLabel, codeTextField, underline)
        
        self.snp.makeConstraints {
            $0.height.equalTo(0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(26)
            $0.right.equalTo(modeChangeButton.snp.left).offset(-8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(26)
        }
        
        modeChangeButton.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(26)
            $0.width.equalTo(88)
            $0.height.equalTo(32)
        }
        
        codeTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(31)
            $0.left.right.equalToSuperview().inset(26)
        }
        
        underline.snp.makeConstraints {
            $0.left.right.equalTo(codeTextField)
            $0.top.equalTo(codeTextField.snp.bottom).offset(4)
            $0.height.equalTo(2)
        }
        
        codeNoticeImageView.snp.makeConstraints {
            $0.top.equalTo(codeTextField.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }
        
        codeNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(codeNoticeImageView.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
    }
}

extension Reactive where Base: CodePopupView {
    var switchMode: Binder<CodePopupView.Mode> {
        return Binder(base) { base, mode in
            let isInput = (mode == .input)
            base.titleLabel.text = isInput ? "바코드 입력" : "바코드 스캔"
            base.descriptionLabel.text = isInput ? "스캔이 안 되나요? 직접 입력해보세요." : "상품의 바코드를 스캔하세요."
            base.modeChangeButton.setTitle(isInput ? "바코드 스캔" : "바코드 입력", for: .normal)
            
            if isInput {
                _ = base.codeTextField.becomeFirstResponder()
            } else {
                _ = base.codeTextField.resignFirstResponder()
                base.codeTextField.text = ""
            }
            
            base.snp.updateConstraints {
                $0.height.equalTo(isInput ? 300 : 117)
            }
            
            UIView.animate(withDuration: 0.3) {
                base.superview?.layoutIfNeeded()
            }
        }
    }
}
