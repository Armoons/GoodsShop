//
//  CartModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 26.11.2021.
//

import Foundation

class CartModel {
    var selectedGoods: [String:Int] = [:]
    
    func append(goods: GoodsInfo) {
        selectedGoods[goods.id] = 1
    }
    
    func remove(goods: GoodsInfo) {
        selectedGoods.removeValue(forKey: goods.id)
    }
}
