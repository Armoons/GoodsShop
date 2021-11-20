//
//  ShoppingSubtotalView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 17.11.2021.
//

import Foundation
import UIKit

class ShoppingSubtotalView: UIView {
    
    private let subtotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "Subtotal:"
        label.textColor = .white
        return label
    }()
    
    var subtotalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.textColor = .white
        label.text = "0" + "₽"
        label.textAlignment = .right
        return label
    }()
    
    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "Delivery:"
        label.textColor = .white
        return label
    }()
    
    private let deliveryStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "Free"
        label.textAlignment = .right

        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        for ui in [subtotalLabel, subtotalPriceLabel, deliveryLabel, deliveryStatusLabel] {
            self.addSubview(ui)
        }
        
        self.backgroundColor = Colors.mainBlue
        self.layer.cornerRadius = 20
        
        subtotalLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(5)
            $0.width.equalTo(121)
            $0.height.equalTo(36)
        }
        
        subtotalPriceLabel.snp.makeConstraints{
            $0.right.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(5)
            $0.width.equalTo(100)
            $0.height.equalTo(36)
        }
        
        deliveryLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(121)
            $0.height.equalTo(36)
        }
        
        deliveryStatusLabel.snp.makeConstraints{
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(60)
            $0.height.equalTo(38)
        }
        
    }
    
}
