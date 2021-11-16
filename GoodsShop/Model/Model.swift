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
    static let plus: UIImage = UIImage(named: "PlusButton")!
    static let testImage: UIImage = UIImage(named: "TestImage")!
    static let CancelSort: UIImage = UIImage(named: "CancelSort")!
    static let ChangeSortStatus: UIImage = UIImage(named: "ChangeSortStatus")!
    
}

struct CellID {
    static let goodsCellID: String = "goodsCell"
}


struct Colors {
    static let mainBlue: UIColor = UIColor(red: 39/255, green: 89/255, blue: 156/255, alpha: 1)
    static let background: UIColor = UIColor(red: 226/255, green: 212/255, blue: 196/255, alpha: 1)
}

struct loadedInfo {
    static var array: [GoodsInfo] = []
}

//let GoodsArray: [GoodsInfo] = [
//    
//    GoodsInfo(image: "rfrf", price: 12, name: "rwfwr", weight: 13, id: "rfrfrfr", desc: "ewrtwrt"),
//    GoodsInfo(image: "rfrf", price: 12, name: "rwfwr", weight: 13, id: "rfrfrfr", desc: "ewrtwrt"),
//    GoodsInfo(image: "rfrf", price: 12, name: "rwfwr", weight: 13, id: "rfrfrfr", desc: "ewrtwrt"),
//    GoodsInfo(image: "rfrf", price: 12, name: "rwfwr", weight: 13, id: "rfrfrfr", desc: "ewrtwrt"),
//    GoodsInfo(image: "rfrf", price: 12, name: "rwfwr", weight: 13, id: "rfrfrfr", desc: "ewrtwrt")
//    
//]


