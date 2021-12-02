//
//  CartModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 26.11.2021.
//

import Foundation

protocol CartModelDelegate {
    func getSelectedGoodsDict(dict: [String:Int])
}

class CartModel {
    private var selectedGoods: [String:Int] = [:]
    var delegate: CartModelDelegate?
    
}

extension CartModel: CatalogueViewControllerDelegateForModel {
    func getSelectedID(id: String) ->  [String:Int] {
        selectedGoods[id] = 1
        
        print("SELECT:", selectedGoods)
        return (selectedGoods)

    }
    
    func getDeselectedID(id: String) ->  [String:Int] {
        selectedGoods.removeValue(forKey: "\(id)")
        print("DESELECT:", selectedGoods)
        return (selectedGoods)
    }
    
    func cartTouched() {
        delegate?.getSelectedGoodsDict(dict: selectedGoods)
    }
}
