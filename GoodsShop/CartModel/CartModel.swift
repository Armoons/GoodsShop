//
//  CartModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 26.11.2021.
//

import Foundation

class CartModel {
    
    private var selectedGoods: [String:Int] = [:]
    
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
    
    
}
