//
//  GoodsLoader.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 08.11.2021.
//

import Foundation

protocol GoodsLoaderDelegate {
    func loaded(goodsInfo: [GoodsInfo])
}

class GoodsLoader {
    
//    var goodsInfoArray = [GoodsInfo]()
    let urlString = "http://94.127.67.113:8099/getGoods"
    
    var delegate: GoodsLoaderDelegate?
    
    func loadInfo() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }

            do {
                let lessons = try JSONDecoder().decode([GoodsInfo].self, from: data)
                delegate?.loaded(goodsInfo: lessons)
//                print(lessons.first?.name ?? "")
            }  catch {
                print(error)
            }
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)
        }.resume()
    }
}
