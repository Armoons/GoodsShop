//
//  ShoppingCartViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit


class ShoppingCartViewController: UIViewController {
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "Shopping Cart"
        return label
    }()
    
    private let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = Colors.mainBlue
        return view
    }()
    
    private let shoppingListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = Colors.background
        return cv
    }()
    
    private let numberButton = CartChangeNumberButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        for ui in [brandLabel, lineView, shoppingListCollectionView] {
            view.addSubview(ui)
        }
    }
}
