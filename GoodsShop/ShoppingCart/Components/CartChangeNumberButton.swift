//
//  CartChangeNumberButton.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import UIKit
import SnapKit

protocol CartChangeNumberButtonDelegate {
    func plusTouched(count: Int)
    func minusTouched(count: Int)
}

class CartChangeNumberButton: UIButton {
    
    var quantity: Int = 1 
    var delegate: CartChangeNumberButtonDelegate?
    
    private let minus: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(minusTouched), for: .touchUpInside)
        button.setImage(Images.minus, for: .normal)
        return button
    }()
    
    private let plus: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(plusTouched), for: .touchUpInside)
        button.setImage(Images.plusWhite, for: .normal)
        return button
    }()
    
    let number: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 22)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func changeQuantity(newValue: Int) {
        quantity = newValue
        number.text = "\(quantity)"
    }
    
    @objc func plusTouched() {
        quantity += 1
        number.text = "\(quantity)"
        delegate?.plusTouched(count: quantity)
    }
    
    @objc func minusTouched() {
        if number.text != "1"{
            quantity -= 1
            number.text = "\(quantity)"
            delegate?.minusTouched(count: quantity)
        } else { return }
    }

    private func setupUI() {
        
        number.text = "\(quantity)"
        
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
