//
//  BlureView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 10.12.2021.
//

import Foundation
import UIKit

class BlurView: UIView {
        
    private let blurEffect = UIBlurEffect(style: .light)
    private let blurEffectView = UIVisualEffectView()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.setImage(Images.plusBlack, for: .normal)
        button.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        button.addTarget(self, action: #selector(closeTouch), for: .touchUpInside)

        return button
    }()
    private var indexPath: IndexPath?
    private var goodsArray: [GoodsInfo] = []
    
    private let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
                
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        cv.isPagingEnabled = true
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeTouch() {
        self.removeFromSuperview()
    }
    
    func showView(indexPath: IndexPath, goodsArray: [GoodsInfo]) {
        self.indexPath = indexPath
        self.goodsArray = goodsArray
        goodsCollectionView.reloadData()
        goodsCollectionView.scrollToItem(at: indexPath, at: .right, animated: false)
        
    }
    
    func setup() {
        
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        
        blurEffectView.effect = blurEffect
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurEffectView)
        self.addSubview(closeButton)
        blurEffectView.contentView.addSubview(goodsCollectionView)
        
        
        goodsCollectionView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints{
            $0.topMargin.equalToSuperview().inset(10)
            $0.right.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
    }
}


extension BlurView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 4/6 * self.frame.width, height: 1/2 * self.frame.height)
        
        return layout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.frame.width / 6 * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: self.frame.height / 4, left: self.frame.width / 6,
                            bottom: self.frame.height / 4, right: self.frame.width / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = goodsArray[indexPath.row]
        cell.cellForBlurView()
        
        return cell
    }
}
