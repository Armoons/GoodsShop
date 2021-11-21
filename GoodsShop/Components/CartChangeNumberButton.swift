//
//  CartChangeNumberButton.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit
import SnapKit

protocol CartChangeNumberButtonDelegate {
    func plusTouched()
    func minusTouched()
}

class CartChangeNumberButton: UIButton {
    
    
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
    
    @objc func minusTouched() {
        
        if number.text != "1"{
            number.text = "\(Int(number.text!)! - 1)"
            delegate?.minusTouched()
        } else { return }
    }
    
    @objc func plusTouched() {
        delegate?.plusTouched()
        number.text = "\(Int(number.text!)! + 1)"

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
