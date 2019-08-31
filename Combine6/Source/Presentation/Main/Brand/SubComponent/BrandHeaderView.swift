//
//  BrandHeaderView.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

class BrandHeaderView: View<EmptyViewBindable> {
    let descriptionLabel = UILabel()
    let leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 24 + 14 + 6, height: 24))
    let imageView = UIImageView(frame: CGRect(x: 14, y: 0, width: 24, height: 24))
    let textField = UITextField()
    
    func setData(description: String) {
        descriptionLabel.text = description
    }
    
    override func attribute() {
        textField.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .gray245
            $0.placeholder = "브랜드명을 입력하세요"
            $0.clearButtonMode = .always
            $0.leftView = leftView
            $0.leftViewMode = .always
        }
        
        imageView.do {
            $0.image = #imageLiteral(resourceName: "icon_search_gray")
            $0.contentMode = .scaleAspectFit
        }
    }
    
    override func layout() {
        addSubviews(descriptionLabel, textField)
        leftView.addSubview(imageView)
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
}
