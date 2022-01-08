//
//  ShoppingCartView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 26.11.2021.
//

import UIKit

protocol ShoppingCartViewDelegate{
    func getChangedGoodsArray(id: String)
}

class ShoppingCartView: UIView {
    
    private var selectedGoodsArray: [GoodsInfo] = []
    private var priceByArray: Int = 0
    
    var delegate: ShoppingCartViewDelegate?
    
    private let header = HeaderOfView(headerText: "Shopping Cart")
    
    private let shoppingListTableView: UITableView = {
        let tv = UITableView()
        tv.showsVerticalScrollIndicator = false
        tv.register(ShoppingCartTableCell.self, forCellReuseIdentifier: CellID.shoppingCartCellID)
        tv.rowHeight = 150
        tv.allowsSelection = false
        tv.backgroundColor = Colors.background
        return tv
    }()
    
    private let subtotalView = ShoppingSubtotalView()
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
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
        
        for ui in [header, shoppingListTableView, subtotalView, buyButton] {
            self.addSubview(ui)
        }
        
        header.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-15)
            $0.height.equalTo(60)
        }
        
        shoppingListTableView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom).offset(10)
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
        priceByArray = selectedGoodsArray.map{$0.price * $0.count!}.reduce(0, +)
        subtotalView.subtotalPriceLabel.text = "\(priceByArray)"
    }
}

extension ShoppingCartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedGoodsArray[indexPath.row].selected = false
            delegate?.getChangedGoodsArray(id: selectedGoodsArray[indexPath.row].id )
 
            selectedGoodsArray = selectedGoodsArray.filter{$0.selected == true}
            calculateSubtotal()
            shoppingListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGoodsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.shoppingCartCellID, for: indexPath) as! ShoppingCartTableCell
        cell.delegate = self
        cell.data = selectedGoodsArray[indexPath.row]
        cell.changeNumberButton.changeQuantity(newValue: cell.data?.count ?? 0)
        
        return cell
    }
}

extension ShoppingCartView: ShoppingCartViewControllerDelegateToView {
    
    func getSelectedGoods(array: [GoodsInfo]) {
        selectedGoodsArray = array.filter{$0.selected == true}        
        calculateSubtotal()
        shoppingListTableView.reloadData()
    }
}

extension ShoppingCartView: ShoppingCartTableCellDelegate {
    func plusTouched(id: String, number: Int) {
        selectedGoodsArray.first(where: {$0.id == id})!.count = number
        calculateSubtotal()
    }
    
    func minusTouched(id: String, number: Int) {
        selectedGoodsArray.first(where: {$0.id == id})!.count = number
        calculateSubtotal()
    }
}

