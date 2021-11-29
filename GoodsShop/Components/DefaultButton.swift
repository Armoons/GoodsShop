//
//  DefaultButton.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit

class DefaultButton: UIButton {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupUI()
//    }
    
    required init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    convenience init(title: String) {
//        self.init()
//        self.setTitle(title, for: .normal)
//    }
    
    private func setupUI(){
        
        self.layer.cornerRadius = 8
        self.layer.borderColor = Colors.mainBlue.cgColor
        self.layer.borderWidth = 1
        self.titleLabel?.font = UIFont(name: Font.sfBold, size: 14)
        self.titleLabel?.textColor = .black
        self.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(21)
        }
    }
}
