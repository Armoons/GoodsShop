//
//  GetGoodsModel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 08.11.2021.
//

import Foundation
import UIKit

struct GoodsInfo: Decodable{
    let image: String
    let price: Int
    let name: String
    let weight: Int
    let id: String
    let desc: String
}
