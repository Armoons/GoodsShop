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
    
    let bagCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 9)
        label.textColor = .lightGray
        label.text = "10"
        return label
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
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        return button
    }()
    
    let priceButton1: DefaultButton = {
        let button = DefaultButton(title: "Цена вз")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        return button
    }()
    
    let ratingButton: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг уб")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        return button
    }()
    
    let ratingButton1: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг вз")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
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
    
    let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
//    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        goodsCollectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        
        setupContraints()
    }


    func setupContraints() {
        
        for ui in [filterStackView, brandLabel, lineView, filterLabel, shoppingBagButton, bagCountLabel, goodsCollectionView] {
            view.addSubview(ui)
        }
        
        for ui in [ratingButton, priceButton, ratingButton1, priceButton1] {
            filterStackView.addArrangedSubview(ui)
        }
        
        brandLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
            $0.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        bagCountLabel.snp.makeConstraints{
            $0.right.equalTo(shoppingBagButton.snp.left).offset(-2)
            $0.bottom.equalTo(lineView).inset(10)
        }
        
        shoppingBagButton.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(lineView).inset(10)
            $0.width.equalTo(shoppingBagButton.snp.height).multipliedBy(1.0 / 1.0)

        }
        
        filterLabel.snp.makeConstraints{
//            $0.left.lessThanOrEqualTo(10)
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(lineView).offset(10)
            
        }
        
        filterStackView.snp.makeConstraints{
            $0.top.equalTo(lineView).inset(10)
            
            $0.left.greaterThanOrEqualTo(filterLabel.snp.right).inset(10)
//            $0.left.equalTo(filterLabel.snp.right).offset(10)
            $0.right.equalToSuperview().inset(10)
        }
        
        goodsCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterLabel.snp.bottom).offset(30)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 30, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GoodsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = GoodsArray[indexPath.row]
        return cell
    }
    
    
}
