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
    var priceArray: [Int] = []
    var priceByArray: Int = 0
    var priceByChanged: Int = 0

    
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
        tv.register(ShoppingCartTableCell.self, forCellReuseIdentifier: CellID.shoppingCartCellID)
        tv.rowHeight = 150
        
        tv.backgroundColor = Colors.background
        return tv
    }()
    
    private let subtotalView = ShoppingSubtotalView()
    
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

        self.shoppingListTableView.delegate = self
        self.shoppingListTableView.dataSource = self
        
        
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        


        self.backgroundColor = Colors.background
        
        for ui in [brandLabel, lineView, shoppingListTableView, subtotalView, buyButton] {
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
            $0.bottom.equalTo(subtotalView.snp.top).inset(-10)
        }
        
        subtotalView.snp.makeConstraints{
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
    
    func calculateSubtotal() {
        priceArray = selectedGoodsArray.map {$0.price}
        priceByArray = priceArray.reduce(0, +)
        subtotalView.subtotalPriceLabel.text = "\(priceByArray + priceByChanged)"
        
    }
}

extension ShoppingCartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mok.array.count
        return selectedGoodsArray.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartTableCell
        cell.delegate = self
        cell.data = selectedGoodsArray[indexPath.row]
//        cell.data = mok.array[indexPath.row]

        return cell
    }
}

extension ShoppingCartView: ShoppingCartViewControllerDelegate {
    
    func getSelectedGoods(array: [GoodsInfo]) {
        selectedGoodsArray = array
        calculateSubtotal()
//        print(selectedGoodsArray)
        shoppingListTableView.reloadData()
        
    }
}

extension ShoppingCartView: ShoppingCartTableCellDelegate {
    
    func plusTouched(id: String) {
        priceByChanged += selectedGoodsArray.first(where: {$0.id == id})!.price
        
        calculateSubtotal()
    }
    
    func minusTouched(id: String) {
        priceByChanged -= selectedGoodsArray.first(where: {$0.id == id})!.price
        calculateSubtotal()
    }
}

