//
//  Model.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import Foundation
import UIKit

enum SortType {
    case price
    case rating
}

public struct Font {
    static let sfRegular: String = "SFUIDisplay-Regular"
    static let sfBold: String = "SFUIDisplay-Bold"
    static let sfLight: String = "SFUIDisplay-Light"
}

struct Images {
    static let shoppingBag: UIImage = UIImage(named: "ShoppingBag")!
    static let plusWhite: UIImage = UIImage(named: "PlusImageWhite")!
    static let plusBlack: UIImage = UIImage(named: "PlusImageBlack")!
    static let minus: UIImage = UIImage(named: "MinusImage")!
    static let testImage: UIImage = UIImage(named: "TestImage")!
    static let CancelSort: UIImage = UIImage(named: "CancelSort")!
    static let ChangeSortStatus: UIImage = UIImage(named: "ChangeSortStatus")!
    
}

struct CellID {
    static let goodsCellID: String = "goodsCell"
    static let shoppingCartCellID: String = "shoppingCartCell"
}


struct Colors {
    static let mainBlue: UIColor = UIColor(red: 39/255, green: 89/255, blue: 156/255, alpha: 1)
    static let background: UIColor = UIColor(red: 226/255, green: 212/255, blue: 196/255, alpha: 1)
}

struct loadedInfo {
    static var array: [GoodsInfo] = []
}

struct selectedGoods {
    static var array: [GoodsInfo] = []
}

struct mok {
    static var array: [GoodsInfo] =
    [GoodsInfo(image: "rge", price: 123, name: "efef", weight: 123, id: "efrr", desc: "erwerw"),
     GoodsInfo(image: "rge", price: 1234, name: "ef2ef", weight: 123, id: "e4rr", desc: "erwerw"),
     GoodsInfo(image: "rge", price: 123, name: "efef", weight: 123, id: "efrrr", desc: "erwerw2")]
}



