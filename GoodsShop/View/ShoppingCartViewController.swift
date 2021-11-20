//
//  ShoppingCartViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit


class ShoppingCartViewController: UIViewController {
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "Shopping Cart"
        return label
    }()
    
    private let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = Colors.mainBlue
        return view
    }()
    
    let shoppingListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = Colors.background
        return cv
    }()
    
    private let subtotalVew = ShoppingSubtotalView()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(Colors.mainBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: Font.sfBold, size: 30)

        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
        
    }
    
    func updateUI() {
        shoppingListCollectionView.reloadData()
        subtotalVew.subtotalPriceLabel.text = "\(selectedGoods.array.reduce(0, {$0 + $1.price}))"
        
    }
    
    private func setupUI() {
        
        shoppingListCollectionView.register(ShoppingCartViewCell.self, forCellWithReuseIdentifier: CellID.shoppingCartCellID)
        
        shoppingListCollectionView.delegate = self
        shoppingListCollectionView.dataSource = self
        view.backgroundColor = Colors.background
        
        for ui in [brandLabel, lineView, shoppingListCollectionView, subtotalVew, buyButton] {
            view.addSubview(ui)
        }
        
        brandLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
            $0.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        shoppingListCollectionView.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(subtotalVew.snp.top).inset(-10)
//            $0.height.equalTo(400)
        }
        
        subtotalVew.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(buyButton.snp.top).inset(-15)
            $0.height.equalTo(90)
            $0.width.equalTo(350)
        }
        
        buyButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(70)
        }
    }
}

extension ShoppingCartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedGoods.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartViewCell
        cell.data = selectedGoods.array[indexPath.row]
        return cell
    }
    
}
