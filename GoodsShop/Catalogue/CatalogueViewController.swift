//
//  ViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit

protocol CatalogueViewControllerDelegateForView {
    func getGoodsArray(array: [GoodsInfo])
}

protocol CatalogueViewControllerDelegateForShopping {
    func getGoodsArray(array: [GoodsInfo])
}

class CatalogueViewController: UIViewController {
        
    private let loader = GoodsService()
    private var catalogueView = CatalogueView()
    private var goodsArray: [GoodsInfo] = []
    var viewDelegate: CatalogueViewControllerDelegateForView?
    var shoppingDelegate: CatalogueViewControllerDelegateForShopping?
    private let shoppingCartVC = ShoppingCartViewController()
    
    override func loadView() {
        self.view = catalogueView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewDelegate = catalogueView
        catalogueView.delegate = self
    
        loader.addDelegate(delegate: self)
        loader.loadInfo()
        
        self.shoppingDelegate = shoppingCartVC
    }
}

extension CatalogueViewController: GoodsServiceDelegate {
    var id: String {
        "CatalogueVC"
    }
    
    func loaded(goodsInfo: [GoodsInfo]) {
        viewDelegate?.getGoodsArray(array: goodsInfo)
    }
}

extension CatalogueViewController: CatalogueViewDelegate {
    func cartTouch(array: [GoodsInfo]) {
        show(shoppingCartVC, sender: self)
        shoppingDelegate?.getGoodsArray(array: array)
    }
}

