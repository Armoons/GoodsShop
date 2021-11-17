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
    
    private let shoppingListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = Colors.background
        return cv
    }()
    
    private let subtotalVew = ShoppingSubtotalView()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = Colors.mainBlue
        button.backgroundColor = .white
        button.titleLabel?.text = "Buy"
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
            $0.bottom.equalTo(subtotalVew.snp.top).offset(10)
        }
        
        subtotalVew.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(buyButton).inset(25)
            $0.height.equalTo(25)
            $0.width.equalTo(90)
        }
        
        buyButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().inset(20)
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
        return loadedInfo.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartViewCell
        cell.data = loadedInfo.array[indexPath.row]
        return cell

    }
    
    
}
