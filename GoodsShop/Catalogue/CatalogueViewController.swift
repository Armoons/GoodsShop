//
//  ViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit

protocol CatalogueViewControllerDelegate {
    func getGoodsArray(array: [GoodsInfo])
}

class CatalogueViewController: UIViewController {
        
    private let loader = GoodsService()
    private var catalogueView = CatalogueView()
    private var goodsArray: [GoodsInfo] = []
    var delegate: CatalogueViewControllerDelegate?
    private let shoppingCartVC = ShoppingCartViewController()
//
//    private var goodsInfoArray: [GoodsInfo] = []
//    private var currentGoodsNumber = 0
//
//
    
    override func loadView() {
        super.loadView()
        
        self.view = catalogueView
        self.delegate = catalogueView
        catalogueView.delegate = self
        
        loader.delegate = self
        loader.loadInfo()
    }
}

extension CatalogueViewController: GoodsServiceDelegate {
    func loaded(goodsInfo: [GoodsInfo]) {
        goodsArray = goodsInfo
        delegate?.getGoodsArray(array: goodsArray)
    }
}

extension CatalogueViewController: CatalogueViewDelegate {
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


