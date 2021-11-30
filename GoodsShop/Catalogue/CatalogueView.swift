//
//  CatalogueView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 24.11.2021.
//

import Foundation
import UIKit

protocol CatalogueViewDelegate {
    func cartTouch()
    func goodsSelect(id: String)
    func goodsDeselect(id: String)
}

class CatalogueView: UIView {
    
    var delegate: CatalogueViewDelegate?
    
    var goodsInfoArray: [GoodsInfo] = []
    var selectedGoodsArray: [GoodsInfo] = []
    var selectedGoodsIDArray: [String] = []

    
    private var currentGoodsNumber = 0
    
    private let sortView = SortView()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "GOODS"
        return label
    }()
    
    private let shoppingBagButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.shoppingBag, for: .normal)
        button.addTarget(self, action: #selector(shoppingBagTouched), for: .touchUpInside)
        return button
    }()
    
    private let bagQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 9)
        label.textColor = .black
        label.text = "0"
        label.isHidden = true
        return label
    }()
    
    private let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = Colors.mainBlue
        return view
    }()
    
    private let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = Colors.background
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.goodsCollectionView.delegate = self
        self.goodsCollectionView.dataSource = self
        sortView.delegate = self

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func shoppingBagTouched() {
        delegate?.cartTouch()
    }
    
    private func setupUI() {
        goodsCollectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)

        
        self.backgroundColor = Colors.background
        
        for ui in [brandLabel, lineView, shoppingBagButton, bagQuantityLabel, goodsCollectionView, sortView] {
            self.addSubview(ui)
        }
        
        sortView.snp.makeConstraints{
            $0.top.equalTo(lineView).offset(10)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        brandLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.topMargin.equalToSuperview().offset(10)
            $0.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints{
            $0.top.equalTo(brandLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        bagQuantityLabel.snp.makeConstraints{
            $0.right.equalTo(shoppingBagButton.snp.left).offset(-2)
            $0.bottom.equalTo(lineView).inset(10)
        }
        
        shoppingBagButton.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(lineView).inset(10)
            $0.width.equalTo(shoppingBagButton.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        goodsCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

extension CatalogueView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 2 - 30, height: 210)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsInfoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = goodsInfoArray[indexPath.row]
        
        if selectedGoodsIDArray.contains(cell.data!.id) {
            cell.cellSelected(animation: false)
        } else { cell.cellDeselected(animation: false) }
        
        cell.delegate = self
        return cell
    }
}


    
extension CatalogueView: SortViewDelegate {
    func priceSort(newGoodsArray: [GoodsInfo]) {
        goodsInfoArray = newGoodsArray
        goodsCollectionView.reloadData()
    }

    func ratingSort(newGoodsArray: [GoodsInfo]) {
        goodsInfoArray = newGoodsArray
        goodsCollectionView.reloadData()
    }
}

extension CatalogueView: GoodsCollectionViewCellDelegate {
    
    func didSelectNewGoods(id: String) {
        currentGoodsNumber += 1
        if currentGoodsNumber > 0 {bagQuantityLabel.isHidden = false}
        bagQuantityLabel.text = "\(currentGoodsNumber)"
        
        selectedGoodsArray.append(goodsInfoArray.first(where: {$0.id == id})!)
        selectedGoodsIDArray.append(id)
        print("selectedID", selectedGoodsIDArray)

        
        delegate?.goodsSelect(id: id)
    }
    
    func didDeselectGoods(id: String) {
        currentGoodsNumber -= 1
        if currentGoodsNumber == 0 {bagQuantityLabel.isHidden = true}
        bagQuantityLabel.text = "\(currentGoodsNumber)"
        
        selectedGoodsArray.append(goodsInfoArray.first(where: {$0.id == id})!)
        selectedGoodsIDArray.remove(at: selectedGoodsIDArray.firstIndex(where: {$0 == id})!)
        print("deselectedID", selectedGoodsIDArray)

        delegate?.goodsDeselect(id: id)
    }
}
    
extension CatalogueView: CatalogueViewControllerDelegateForView {
    
    
    func getGoodsArray(array: [GoodsInfo]) {
        goodsInfoArray = array
        sortView.getGoodsArray(array: array)
        goodsCollectionView.reloadData()
    }
    
}
    
