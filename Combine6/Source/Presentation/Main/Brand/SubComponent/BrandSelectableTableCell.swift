//
//  BrandSelectableTableCell.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import Kingfisher
import Then
import RxSwift
import RxCocoa

class BrandSelectableTableCell: BrandTableCell {
    let disposeBag = DisposeBag()
    let selectButton = UIButton()
    
    var brand: Brand?
    
    override func setData(brand: Brand) {
        super.setData(brand: brand)
        self.brand = brand
    }
    
    override func attribute() {
        super.attribute()
        
        selectButton.do {
            $0.setTitle("추가하기", for: .normal)
            $0.setTitle("추가완료", for: .selected)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitleColor(.gray64, for: .selected)
            $0.setBackgroundImage(UIColor.black.asImage, for: .normal)
            $0.setBackgroundImage(UIColor.lightGray.asImage, for: .selected)
            $0.layer.cornerRadius = 18
            $0.clipsToBounds = true
        }
        
        descriptionLabel.do {
            $0.adjustsFontSizeToFitWidth = true
        }
        
        selectButton.rx.tap
            .bind(onNext: { [weak selectButton] _ in
                selectButton?.isSelected.toggle()
            })
            .disposed(by: disposeBag)
    }
    
    override func layout() {
        super.layout()
        addSubview(selectButton)
        
        selectButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-16)
            $0.width.equalTo(90)
            $0.height.equalTo(36)
        }
        selectButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        descriptionLabel.snp.makeConstraints {
            $0.right.equalTo(selectButton.snp.left).offset(-4)
        }
    }
}
