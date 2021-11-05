//
//  Model.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import Foundation
import UIKit

struct GoodsInfo {
    let image: UIImage
    let name: String
    let rating: Double
    let price: Double
    let id: String
    let description: String
}

struct GoodsShowInfo {
    let image: UIImage
    let name: String
    let price: Double
    let description: String
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


    
}

struct CellID {
    static let goodsCellID: String = "goodsCell"
}


struct Colors {
    static let mainBlue: UIColor = UIColor(red: 39/255, green: 89/255, blue: 156/255, alpha: 1)
}

let GoodsArray: [GoodsShowInfo] = [
    GoodsShowInfo(image: Images.testImage, name: "Товар 1", price: 300.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 2", price: 400.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 1", price: 300.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 2", price: 400.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 1", price: 300.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 2", price: 400.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 1", price: 300.0, description: "Short description"),
    GoodsShowInfo(image: Images.testImage, name: "Товар 2", price: 400.0, description: "Short description")

]
//[GoodsInfo(image: Images.testImage, name: "Товар 1", rating: 400, price: 300.0, id: "wrtwert", description: "Товар 1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
// GoodsInfo(image: Images.testImage, name: "Товар 2", rating: 300, price: 205.0, id: "gerge", description: "Товар 2 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua")
//]


