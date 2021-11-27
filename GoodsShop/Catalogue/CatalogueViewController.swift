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

protocol CatalogueViewControllerDelegateForModel {
    func getSelectedID(id: String) ->  [String:Int]
    func getDeselectedID(id: String) ->  [String:Int]

}


class CatalogueViewController: UIViewController {
        
    private let loader = GoodsService()
    private var catalogueView = CatalogueView()
    private var goodsArray: [GoodsInfo] = []
    var viewDelegate: CatalogueViewControllerDelegateForView?
    var modelDelegate: CatalogueViewControllerDelegateForModel?
    private var selectedGoodsDict: [String:Int] = [:]
    
    private let cartModel = CartModel()

    private let shoppingCartVC = ShoppingCartViewController()
//
//    private var goodsInfoArray: [GoodsInfo] = []
//    private var currentGoodsNumber = 0
//
//
    
    override func loadView() {
        super.loadView()
        
        self.view = catalogueView
        self.viewDelegate = catalogueView
        catalogueView.delegate = self
        
        loader.delegate = self
        loader.loadInfo()
        
        self.modelDelegate = cartModel
        
    }
}

extension CatalogueViewController: GoodsServiceDelegate {
    func loaded(goodsInfo: [GoodsInfo]) {
        goodsArray = goodsInfo
        viewDelegate?.getGoodsArray(array: goodsArray)
    }
}

extension CatalogueViewController: CatalogueViewDelegate {
    
    func goodsSelect(id: String) {
        selectedGoodsDict = (modelDelegate?.getSelectedID(id: id))!
    }
    
    func goodsDeselect(id: String) {
        selectedGoodsDict = (modelDelegate?.getDeselectedID(id: id))!
    }
    
    func cartTouch() {
        show(shoppingCartVC, sender: self)
    }
}



//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        view.backgroundColor = Colors.background

//
//        setupContraints()
//    }
//
//    func updateBagQuantityLabel(newValue: Int) {
//        bagQuantityLabel.text = "\(newValue)"
//    }
//

//
//   
//

//

//

//


