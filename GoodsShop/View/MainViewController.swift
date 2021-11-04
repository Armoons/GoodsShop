//
//  ViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit
import SnapKit


class MainViewController: UIViewController {

    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "GOODS"
        return label
    }()
    
    let shoppingBagButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.shoppingBag, for: .normal)
        return button
    }()
    
    let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = .blue
        return view
    }()
    
    let filterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 14)
        label.text = "Фильтр:"
        return label
    }()
    
    let priceButton: DefaultButton = {
        let button = DefaultButton(title: "Цена уб")
        return button
    }()
    
    let priceButton1: DefaultButton = {
        let button = DefaultButton(title: "Цена вз")
        return button
    }()
    
    let ratingButton: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг уб")
        return button
    }()
    
    let ratingButton1: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг вз")
        return button
    }()
    
    let filterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 5
        return stack
    }()
    
//    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupContraints()
    }


    func setupContraints() {
        
        for ui in [filterStackView, brandLabel, lineView, filterLabel] {
            view.addSubview(ui)
        }
        
        for ui in [ratingButton, priceButton, ratingButton1, priceButton1] {
            filterStackView.addArrangedSubview(ui)
        }
        
        brandLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
            $0.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        filterLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(lineView).offset(10)
            
            
        }
        
        filterStackView.snp.makeConstraints{
            $0.top.equalTo(lineView).inset(10)
            $0.left.equalTo(filterLabel.snp.right).offset(10)
            $0.right.equalToSuperview().inset(10)
//            $0.width.equalTo(view.frame.width - 20 - filterLabel.frame.width)
        }
        
        
        
        
    }
}

