//
//  ViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let loader = GoodsService()
    private let shoppingCartVC = ShoppingCartViewController()

    private var goodsInfoArray: [GoodsInfo] = []
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        goodsCollectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        
        loader.delegate = self
        loader.loadInfo()

        sortView.delegate = self
        
        setupContraints()
    }

    func updateBagQuantityLabel(newValue: Int) {
        bagQuantityLabel.text = "\(newValue)"
    }
    
    @objc func shoppingBagTouched() {
        show(shoppingCartVC, sender: self)
    }
    
    
    
    private func setupContraints() {
        
        for ui in [brandLabel, lineView, shoppingBagButton, bagQuantityLabel, goodsCollectionView, sortView] {
            view.addSubview(ui)
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 30, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(goodsInfoArray)
        return goodsInfoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = goodsInfoArray[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension MainViewController: GoodsServiceDelegate {
    func loaded(goodsInfo: [GoodsInfo]) {
        goodsInfoArray = goodsInfo
        loadedInfo.array = goodsInfo
        self.goodsCollectionView.reloadData()
    }
}

extension MainViewController: GoodsCollectionViewCellDelegate {
    
    func didAddNewGoods() {
        currentGoodsNumber += 1
        if currentGoodsNumber > 0 {bagQuantityLabel.isHidden = false}
        updateBagQuantityLabel(newValue: currentGoodsNumber)
    }
    
    func didRemovedGoods() {
        currentGoodsNumber -= 1
        if currentGoodsNumber == 0 {bagQuantityLabel.isHidden = true}
        updateBagQuantityLabel(newValue: currentGoodsNumber)
    }
}

extension MainViewController: SortViewDelegate {
    func priceSort(newGoodsArray: [GoodsInfo]) {
        goodsInfoArray = newGoodsArray
        goodsCollectionView.reloadData()
    }
    
    func ratingSort(newGoodsArray: [GoodsInfo]) {
        goodsInfoArray = newGoodsArray
        goodsCollectionView.reloadData()
    }
}

