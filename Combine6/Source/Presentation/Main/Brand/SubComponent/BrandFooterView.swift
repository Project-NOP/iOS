//
//  BrandFooterView.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit

class BrandFooterView: View<EmptyViewBindable> {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let actionButton = UIButton()
    
    func setData(title: String, actionTitle: String?) {
        titleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)
    }
    
    override func attribute() {
        imageView.do {
            $0.image = #imageLiteral(resourceName: "icon_notice_gray")
        }
        
        titleLabel.do {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .gray185
        }
        
        actionButton.do {
            $0.setTitleColor(.gray185, for: .normal)
        }
    }
    
    override func layout() {
        addSubviews(imageView, titleLabel, actionButton)
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(8)
        }
        
        actionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
}
