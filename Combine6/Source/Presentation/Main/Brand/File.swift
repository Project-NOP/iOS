//
//  BrandTableCell.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import Kingfisher

class BrandTableCell: UITableViewCell {
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func setData(brand: Brand) {
        titleLabel.text = brand.name
        descriptionLabel.text = brand.description
        logoImageView.kf.setImage(with: brand.imageURL)
    }
    
    func attribute() {
        titleLabel.do {
            $0.font = .systemFont(ofSize: 18, weight: .bold)
        }
        
        descriptionLabel.do {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .gray245
        }
        
        logoImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func layout() {
        addSubviews(titleLabel, descriptionLabel, logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(26)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(logoImageView.snp.right).offset(12)
            $0.bottom.equalTo(self.snp.centerY)
            $0.right.equalToSuperview().offset(-26)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.equalTo(logoImageView.snp.right).offset(12)
            $0.top.equalTo(self.snp.centerY)
            $0.right.equalToSuperview().offset(-26)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
