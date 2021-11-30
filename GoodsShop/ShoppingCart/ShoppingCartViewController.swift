//
//  ShoppingCartViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit

protocol ShoppingCartViewControllerDelegate {
    func getSelectedGoods(array: [GoodsInfo])
}


class ShoppingCartViewController: UIViewController {
    
    private var goodsArray: [GoodsInfo] = []
    private var selectedGoodsDict: [String : Int] = [:]
    private var selectedGoodsArray: [GoodsInfo] = []

    private let cartModel = CartModel()
//    private let catalogueVC = CatalogueViewController()
    private let loader = GoodsService()
    private let cartView = ShoppingCartView()
        
    var delegate: ShoppingCartViewControllerDelegate?
    
    override func loadView() {
        self.view = cartView

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = cartView

    }
    
    func createSelectedGoodsArray() {
        let keys = Array(selectedGoodsDict.keys)
        
        selectedGoodsArray = goodsArray.filter{keys.contains($0.id)}
//        print("CHECKKEYS:", selectedGoodsArray.first?.id)
        delegate?.getSelectedGoods(array: selectedGoodsArray)
        
    }

}



extension ShoppingCartViewController: CartModelDelegate {
    func getSelectedGoodsDict(dict: [String : Int]){
        selectedGoodsDict = dict
        createSelectedGoodsArray()
    }
}

extension ShoppingCartViewController: GoodsServiceDelegate {
    var id: String {
        "ShoppingCartVC"
    }
    
    
    func loaded(goodsInfo: [GoodsInfo]) {
        goodsArray = goodsInfo
    }  
}


//    func updateUI() {
//        shoppingListCollectionView.reloadData()
//
//        subtotalValue = selectedGoods.array.reduce(0, {$0 + $1.price})
//
//        changedSubtotalValue = subtotalValue
//        subtotalVew.subtotalPriceLabel.text = "\(subtotalValue!)"
//    }


//extension ShoppingCartViewController: ShoppingCartViewCellDelegate {
//    func plusTouchedFromCell(newPrice: Int) {
//        changedSubtotalValue! += newPrice
////        subtotalValue! += newPrice
//        subtotalVew.subtotalPriceLabel.text = "\(changedSubtotalValue!)"
//        return
//    }
//
//    func minusTouchedFromCell(newPrice: Int) {
//        changedSubtotalValue! -= newPrice
//
////        subtotalValue! -= newPrice
//        subtotalVew.subtotalPriceLabel.text = "\(changedSubtotalValue!)"
//        return
//    }
//}

