//
//  SelectedGoodsView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 10.12.2021.
//

import Foundation
import UIKit

class SelectedGoodsView: UIView {
    
    private var goodsArray: [GoodsInfo] = []
    
    private let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        cv.backgroundColor = Colors.background
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(goodsCollectionView)
    }
    
}

extension SelectedGoodsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 2, height: self.frame.width)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        return cell
    }
    
    
    
}
