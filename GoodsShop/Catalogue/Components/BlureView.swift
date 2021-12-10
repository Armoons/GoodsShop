//
//  BlureView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 10.12.2021.
//

import Foundation
import UIKit

class BlurView: UIView {
    
    
    private let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
    private let blurEffectView = UIVisualEffectView()
    
    let leftAndRightPaddings: CGFloat = 15.0
    let topAndBottomPaddings: CGFloat = 15.0
    
    private var goodsArray: [GoodsInfo] = []
    
    private let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
//        layout.targetContentOffset(forProposedContentOffset: <#T##CGPoint#>, withScrollingVelocity: <#T##CGPoint#>)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        cv.layer.opacity = 0.5
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
        
        
        
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
//        blurEffectView.alpha = 1
        blurEffectView.effect = blurEffect
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        
        self.addSubview(blurEffectView)
        self.addSubview(goodsCollectionView)
        
        goodsCollectionView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }

    }
    
}


extension BlurView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: self.frame.width / 2, height: self.frame.height / 2)


        
        let bounds = self.bounds
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 275, height: 386)
        
        return layout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.frame.width / 6 * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left = self.frame.width / 6
        return UIEdgeInsets(top: self.frame.height / 4, left: left,
                            bottom: self.frame.height / 4, right: left)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return goodsArray.count
        return Mok.array.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = Mok.array[indexPath.row]

        return cell
    }
    
    
    
}
