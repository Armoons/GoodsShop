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
}

extension ShoppingCartViewController: CatalogueViewControllerDelegateForShopping {
    func getGoodsArray(array: [GoodsInfo]) {
        delegate?.getSelectedGoods(array: array)
    }
}



