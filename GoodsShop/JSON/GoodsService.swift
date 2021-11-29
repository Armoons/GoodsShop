//
//  GoodsLoader.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 08.11.2021.
//

import Foundation

protocol GoodsServiceDelegateForCatalogue {
    func loaded(goodsInfo: [GoodsInfo])
}

protocol GoodsServiceDelegateForShopping {
    func loaded(goodsInfo: [GoodsInfo])
}

class GoodsService {

    static let urlString = "http://94.127.67.113:8099/getGoods"
    
    var delegateCatalogue: GoodsServiceDelegateForCatalogue?
    var delegateShopping: GoodsServiceDelegateForShopping?

    
    func loadInfo() {
        guard let url = URL(string: Self.urlString) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }

            do {
                let goodsArray = try JSONDecoder().decode([GoodsInfo].self, from: data)
                DispatchQueue.main.async {
                    delegateShopping?.loaded(goodsInfo: goodsArray)
                    delegateCatalogue?.loaded(goodsInfo: goodsArray)
                }
            }  catch {
                print(error)
            }
        }.resume()
    }
}
