//
//  CartChangeNumberButton.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit
import SnapKit

class CartChangeNumberButton: UIButton {
    
    private let minus: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.minus
        return iv
    }()
    
    private let plus: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.plusWhite
        return iv
    }()
    
    private let number: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 22)
        label.textColor = .white
        label.text = "1"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.backgroundColor = Colors.mainBlue
        self.layer.cornerRadius = 8
        
        for ui in [minus, plus, number] {
            self.addSubview(ui)
        }
        
        minus.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(21)
        }
        
        number.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        plus.snp.makeConstraints{
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(21)
        }
    }
}
