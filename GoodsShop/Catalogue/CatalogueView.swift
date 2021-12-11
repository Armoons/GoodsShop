//
//  CatalogueView.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 24.11.2021.
//

import UIKit

protocol CatalogueViewDelegate {
    func cartTouch(array: [GoodsInfo])
}


class CatalogueView: UIView {
    
    var delegate: CatalogueViewDelegate?
    var countOfSelected: Int = 0
    var goodsInfoArray: [GoodsInfo] = []
    var defaultGoodsArray: [GoodsInfo] = []
    private var currentGoodsNumber = 0

    private let sortView = SortView()
    
    private let header = HeaderOfView(headerText: "GOODS")
    
    private let blurView = BlurView()
    
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
    
//    private let lineView: LineUnderBrandLabel = {
//        let view = LineUnderBrandLabel()
//        view.backgroundColor = Colors.mainBlue
//        return view
//    }()
    
    private let goodsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        

        self.goodsCollectionView.delegate = self
        self.goodsCollectionView.dataSource = self
        sortView.delegate = self

        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func shoppingBagTouched() {
        delegate?.cartTouch(array: goodsInfoArray)
    }
    
    private func setupUI() {
        
        self.backgroundColor = Colors.background
        
        for ui in [header, shoppingBagButton, bagQuantityLabel, goodsCollectionView, sortView] {
            self.addSubview(ui)
        }
        
        sortView.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        header.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-25)
            $0.height.equalTo(60)
        }

        bagQuantityLabel.snp.makeConstraints{
            $0.right.equalTo(shoppingBagButton.snp.left).offset(-2)
            $0.bottom.equalTo(shoppingBagButton)
        }
        
        shoppingBagButton.snp.makeConstraints{
            $0.topMargin.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(header.snp.bottom).inset(10)
            $0.width.equalTo(shoppingBagButton.snp.height).multipliedBy(1.0 / 1.0)
        }
        
        goodsCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortView.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}

extension CatalogueView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.addSubview(blurView)
        blurView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        blurView.showView(indexPath: indexPath, goodsArray: goodsInfoArray)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 2 - 30, height: 210)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsInfoArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = goodsInfoArray[indexPath.row]

        if (cell.data?.selected == true) {
            cell.cellSelected(animation: false)
        } else {cell.cellDeselected(animation: false)}
        
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
        goodsInfoArray.first(where: {$0.id == id})!.selected = true
        goodsInfoArray.first(where: {$0.id == id})!.count = 1
        
        sortView.getGoodsArray(array: goodsInfoArray)

        
        currentGoodsNumber = goodsInfoArray.filter {$0.selected == true}.count
        if currentGoodsNumber > 0 {bagQuantityLabel.isHidden = false}
        bagQuantityLabel.text = "\(currentGoodsNumber)"
    }
    
    func didDeselectGoods(id: String) {
        goodsInfoArray.first(where: {$0.id == id})!.selected = false
        goodsInfoArray.first(where: {$0.id == id})!.count = 1
        
        sortView.getGoodsArray(array: goodsInfoArray)

        currentGoodsNumber = goodsInfoArray.filter {$0.selected == true}.count
        if currentGoodsNumber == 0 {bagQuantityLabel.isHidden = true}
        bagQuantityLabel.text = "\(currentGoodsNumber)"
    }
}

extension CatalogueView: CatalogueViewControllerDelegateForView {
    func getDeselectedId(id: String) {
        goodsInfoArray.first(where: {$0.id == id})?.selected = false
        
        currentGoodsNumber = goodsInfoArray.filter {$0.selected == true}.count
        if currentGoodsNumber > 0 {bagQuantityLabel.isHidden = false} else {bagQuantityLabel.isHidden = true}
        bagQuantityLabel.text = "\(currentGoodsNumber)"
        
        goodsCollectionView.reloadData()
    }
    
    func getGoodsArray(array: [GoodsInfo]) {
        goodsInfoArray = array
        sortView.defaultGoodsArray = array
        sortView.getGoodsArray(array: array)
        goodsCollectionView.reloadData()
    }
}
    
