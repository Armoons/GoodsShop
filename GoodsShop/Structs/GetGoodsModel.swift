//
//  GetGoodsModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 08.11.2021.
//

class GoodsInfo: Decodable{
    var image: String
    var price: Int
    var name: String
    var weight: Int
    var id: String
    var desc: String
    
    var selected: Bool?
    var count: Int?
    
    init(image: String,  price: Int,  name: String,  weight: Int,  id: String,  desc: String) {
        self.image = image
        self.price = price
        self.name = name
        self.weight = weight
        self.id = id
        self.desc = desc
    }
    
    
}

