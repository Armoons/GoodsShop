//
//  SortView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 15.11.2021.
//

import Foundation
import UIKit

protocol SortViewDelegate {
    func priceSort(newGoodsArray: [GoodsInfo])
    func ratingSort(newGoodsArray: [GoodsInfo])
}

class SortView: UIView {
    
    var goodsInfoArray: [GoodsInfo] = []
    
    var delegate:SortViewDelegate?
    
    private var didPriceSortUsed = false
    private var didRateSortUsed = false
    private var priceSortTouchesNumber = 0
    private var rateSortTouchesNumber = 0
    
    private let sortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 14)
        label.text = "Сортировка:"
        return label
    }()
    
    private let priceArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.ChangeSortStatus
        iv.isHidden = true
        return iv
    }()
    
    
    private let ratingArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.ChangeSortStatus
        iv.isHidden = true
        return iv
    }()
    
    private let priceButton: DefaultButton = {
        let button = DefaultButton(title: "Цена")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        button.addTarget(self, action: #selector(priceTouched), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let ratingButton: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ratingTouched), for: .touchUpInside)
        return button
    }()
    
    private let filterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        
        for ui in [filterStackView,sortLabel, priceArrow, ratingArrow] {
            self.addSubview(ui)
        }
        
        for ui in [priceButton, ratingButton] {
            filterStackView.addArrangedSubview(ui)
        }
        
        sortLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(10)
        }
        
        priceArrow.snp.makeConstraints{
            $0.right.equalTo(priceButton).inset(7)
            $0.centerY.equalTo(priceButton)
            $0.width.height.equalTo(15)
        }
        
        ratingArrow.snp.makeConstraints{
            $0.right.equalTo(ratingButton).inset(3)
            $0.centerY.equalTo(ratingButton)
            $0.width.height.equalTo(15)
        }
        
        filterStackView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(9)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(180)
        }
    }
    
    func resetButton(button: UIButton, arrow: UIImageView, unusedStatus: inout Bool, unusedTouchesNumber: inout Int) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = .clear

        }
        arrow.isHidden = true
        arrow.transform = CGAffineTransform(rotationAngle: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        unusedStatus = false
        unusedTouchesNumber = 0
    }
    
    func setupButton(button: UIButton, arrow: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = Colors.mainBlue
        }
        arrow.isHidden = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.sfBold, size: 12)
        
    }
    
    func changeSort(sortType: SortType,usedStatus: inout Bool, unusedStatus: inout Bool, usedTouchesNumber: inout Int,
                    unusedTouchesNumber: inout Int,usedButton: DefaultButton, usedArrow: UIImageView,
                    unusedButton: DefaultButton, unusedArrow: UIImageView){
        
        goodsInfoArray = loadedInfo.array
        
        if !usedStatus && usedTouchesNumber == 0  {
            usedTouchesNumber = 1
            usedStatus = true

            setupButton(button: usedButton, arrow: usedArrow)
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &unusedTouchesNumber)
            usedButton.titleLabel?.textColor = .black
            
            switch sortType {
            case .rating:
                goodsInfoArray.sort(by: {$0.weight > $1.weight })
            case .price:
                goodsInfoArray.sort(by: {$0.price > $1.price })
            }

        } else if usedStatus && usedTouchesNumber == 1 {
            usedArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            
            usedTouchesNumber = 2
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &unusedTouchesNumber)
            
            switch sortType {
            case .rating:
                goodsInfoArray.sort(by: {$0.weight < $1.weight })
            case .price:
                goodsInfoArray.sort(by: {$0.price < $1.price })
            }
            
        } else if usedStatus && usedTouchesNumber == 2 {
            resetButton(button: usedButton, arrow: usedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &usedTouchesNumber)
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &usedTouchesNumber)

            usedTouchesNumber = 0
            usedStatus = false
            
            goodsInfoArray = loadedInfo.array
        }
        
        print("SORT:\(goodsInfoArray)")
       
    }
    
    @objc func priceTouched() {
        changeSort(sortType: .price, usedStatus: &didPriceSortUsed, unusedStatus: &didRateSortUsed, usedTouchesNumber: &priceSortTouchesNumber, unusedTouchesNumber: &rateSortTouchesNumber, usedButton: priceButton, usedArrow: priceArrow, unusedButton: ratingButton, unusedArrow: ratingArrow)
        delegate?.priceSort(newGoodsArray: goodsInfoArray)
    }
    
    @objc func ratingTouched() {
        changeSort(sortType: .rating, usedStatus: &didRateSortUsed, unusedStatus: &didPriceSortUsed, usedTouchesNumber: &rateSortTouchesNumber, unusedTouchesNumber: &priceSortTouchesNumber, usedButton: ratingButton, usedArrow: ratingArrow, unusedButton: priceButton, unusedArrow: priceArrow)
        delegate?.ratingSort(newGoodsArray: goodsInfoArray)
    }
}

