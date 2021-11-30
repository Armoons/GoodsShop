//
//  ShoppingCartView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 26.11.2021.
//

import Foundation
import UIKit

class ShoppingCartView: UIView {
    
    var selectedGoodsArray: [GoodsInfo] = []
    
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
    
    let shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.rowHeight = 150
        
        tv.backgroundColor = Colors.background
        return tv
    }()

//    let shoppingListCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 0
//        layout.estimatedItemSize = .zero
//
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.showsVerticalScrollIndicator = false
//        cv.backgroundColor = Colors.background
//        return cv
//    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        shoppingListCollectionView.delegate = self
//        shoppingListCollectionView.dataSource = self
        self.shoppingListTableView.delegate = self
        self.shoppingListTableView.dataSource = self
        
//        ShoppingCartViewController().delegate = self
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
//        shoppingListCollectionView.register(ShoppingCartViewCell.self, forCellWithReuseIdentifier: CellID.shoppingCartCellID)
//        shoppingListTableView.register(ShoppingCartTableCell.self, forCellWithReuseIdentifier: CellID.shoppingCartCellID)
        shoppingListTableView.register(ShoppingCartTableCell.self, forCellReuseIdentifier: CellID.shoppingCartCellID)


        self.backgroundColor = Colors.background
        
        for ui in [brandLabel, lineView, shoppingListTableView, subtotalVew, buyButton] {
            self.addSubview(ui)
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
        
        shoppingListTableView.snp.makeConstraints{
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(subtotalVew.snp.top).inset(-10)
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

extension ShoppingCartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mok.array.count
        return selectedGoodsArray.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartTableCell

        cell.data = selectedGoodsArray[indexPath.row]
//        cell.data = mok.array[indexPath.row]

//        cell.delegate = self
        return cell
    }
    
    
}

//extension ShoppingCartView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: 150)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return selectedGoodsArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartViewCell
//        cell.data = selectedGoodsArray[indexPath.row]
////        cell.delegate = self
//        return cell
//    }
//}

extension ShoppingCartView: ShoppingCartViewControllerDelegate {
    
    func getSelectedGoods(array: [GoodsInfo]) {
        selectedGoodsArray = array
        print(selectedGoodsArray)
        shoppingListTableView.reloadData()
    }
}
