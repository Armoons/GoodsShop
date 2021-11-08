//
//  GetGoodsModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 08.11.2021.
//

import Foundation
import UIKit


struct GoodsShowInfo {
    let image: UIImage
    let name: String
    let price: Double
    let description: String
}

struct GoodsInfo: Decodable{
    let image: String
    let price: Int
    let name: String
    let weight: Int
    let id: String
    let desc: String
    
//    init?(data: NSDictionary) {
//        guard let image = data["image"] as? String,
//              let price = data["price"] as? Int,
//              let name = data["name"] as? String,
//              let weight = data["weight"] as? Int,
//              let id = data["id"] as? String,
//              let desc = data["desc"] as? String else { return nil}
//
//        self.image = image
//        self.price = price
//        self.name = name
//        self.weight = weight
//        self.id = id
//        self.desc = desc
//    }
    
}
