//
//  ShoppingCartViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import UIKit

protocol ShoppingCartViewControllerDelegateToView {
    func getSelectedGoods(array: [GoodsInfo])
}

protocol ShoppingCartViewControllerDelegateToVC {
    func getArray(id: String)
}

class ShoppingCartViewController: UIViewController {
    
    private var goodsArray: [GoodsInfo] = []
    private let loader = GoodsService()
    private let cartView = ShoppingCartView()
        
    var delegateView: ShoppingCartViewControllerDelegateToView?
    var delegateVC: ShoppingCartViewControllerDelegateToVC?

    
    override func loadView() {
        self.view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegateView = cartView
        cartView.delegate = self
    }
}

extension ShoppingCartViewController: CatalogueViewControllerDelegateForShopping {
    func getGoodsArray(array: [GoodsInfo]) {
        delegateView?.getSelectedGoods(array: array)
    }
}

extension ShoppingCartViewController: ShoppingCartViewDelegate {
    func getChangedGoodsArray(id: String) {
        delegateVC?.getArray(id: id)
    }

}



