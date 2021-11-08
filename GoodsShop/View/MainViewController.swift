//
//  ViewController.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit
import SnapKit

protocol GoodsCollectionViewCellDelegate {
    func didAddNewGoods()
    func didRemovedGoods()
}

class MainViewController: UIViewController {
    
    var goodsInfoArray: [GoodsInfo] = []
    
    var currentGoodsNumber = 0
    
    var didPriceSortUsed = false
    var didRateSortUsed = false
    var priceSortTouchesNumber = 0
    var rateSortTouchesNumber = 0
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        label.text = "GOODS"
        return label
    }()
    
    let shoppingBagButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.shoppingBag, for: .normal)
        return button
    }()
    
    let bagQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 9)
        label.textColor = .black
        label.text = "0"
        label.isHidden = true
        return label
    }()
    
    let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = Colors.mainBlue
        return view
    }()
    
    let sortLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 14)
        label.text = "Сортировка:"
        return label
    }()
    
    let cancelSortButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.CancelSort, for: .normal)
        button.isHidden = true
        return button
    }()
    
    let priceArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.ChangeSortStatus
        iv.isHidden = true
        return iv
    }()
    
    
    let ratingArrow: UIImageView = {
        let iv = UIImageView()
        iv.image = Images.ChangeSortStatus
        iv.isHidden = true
        return iv
    }()
    
    let priceButton: DefaultButton = {
        let button = DefaultButton(title: "Цена")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        button.addTarget(self, action: #selector(priceTouched), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let ratingButton: DefaultButton = {
        let button = DefaultButton(title: "Рейтинг")
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(ratingTouched), for: .touchUpInside)
        return button
    }()
    
    
    
    
    let filterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    let goodsCollectionView: UICollectionView = {
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
    
//    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        
        goodsCollectionView.delegate = self
        goodsCollectionView.dataSource = self
        goodsCollectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: CellID.goodsCellID)
        
        setupContraints()
        
//        GoodsLoader().loadInfo()
        let loader = GoodsLoader()
        loader.delegate = self
        loader.loadInfo()
        
        
    }
    
    func updateBagQuantityLabel(newValue: Int) {
        bagQuantityLabel.text = "\(newValue)"
    }
    
    func resetButton(button: UIButton, arrow: UIImageView, unusedStatus: inout Bool, unusedTouchesNumber: inout Int) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = .clear

        }
        arrow.isHidden = true
        arrow.transform = CGAffineTransform(rotationAngle: 0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.sfLight, size: 12)
        unusedStatus = false
        unusedTouchesNumber = 0


    }
    
    func setupButton(button: UIButton, arrow: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            button.backgroundColor = Colors.mainBlue
        }
        arrow.isHidden = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Font.sfBold, size: 12)
        
    }
    
    func changeSort(usedStatus: inout Bool, unusedStatus: inout Bool, usedTouchesNumber: inout Int, unusedTouchesNumber: inout Int,usedButton: DefaultButton, usedArrow: UIImageView, unusedButton: DefaultButton, unusedArrow: UIImageView) {
        if !usedStatus && usedTouchesNumber == 0  {
            usedTouchesNumber = 1
            usedStatus = true

            setupButton(button: usedButton, arrow: usedArrow)
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &unusedTouchesNumber)
            usedButton.titleLabel?.textColor = .black
        } else if usedStatus && usedTouchesNumber == 1 {
            usedArrow.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            
            usedTouchesNumber = 2
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &unusedTouchesNumber)
        } else if usedStatus && usedTouchesNumber == 2 {
            resetButton(button: usedButton, arrow: usedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &usedTouchesNumber)
            resetButton(button: unusedButton, arrow: unusedArrow, unusedStatus: &unusedStatus, unusedTouchesNumber: &usedTouchesNumber)

            usedTouchesNumber = 0
            usedStatus = false
        }
    }
    
    @objc func priceTouched() {
        changeSort(usedStatus: &didPriceSortUsed, unusedStatus: &didRateSortUsed, usedTouchesNumber: &priceSortTouchesNumber, unusedTouchesNumber: &rateSortTouchesNumber, usedButton: priceButton, usedArrow: priceArrow, unusedButton: ratingButton, unusedArrow: ratingArrow)
    }
    
    @objc func ratingTouched() {
        changeSort(usedStatus: &didRateSortUsed, unusedStatus: &didPriceSortUsed, usedTouchesNumber: &rateSortTouchesNumber, unusedTouchesNumber: &priceSortTouchesNumber, usedButton: ratingButton, usedArrow: ratingArrow, unusedButton: priceButton, unusedArrow: priceArrow)
    }
    
    

    func setupContraints() {
        
        for ui in [filterStackView, brandLabel, lineView, sortLabel, shoppingBagButton, bagQuantityLabel,
                   goodsCollectionView, priceArrow, ratingArrow, cancelSortButton] {
            view.addSubview(ui)
        }
        
        for ui in [priceButton, ratingButton] {
            filterStackView.addArrangedSubview(ui)
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
        
        sortLabel.snp.makeConstraints{
//            $0.left.lessThanOrEqualTo(10)
            $0.left.equalToSuperview().inset(10)
            $0.top.equalTo(lineView).offset(10)
        }
        
        priceArrow.snp.makeConstraints{
            $0.right.equalTo(priceButton).inset(7)
            $0.centerY.equalTo(priceButton)
            $0.width.height.equalTo(15)
        }
        
        ratingArrow.snp.makeConstraints{
            $0.right.equalTo(ratingButton).inset(3)
            $0.centerY.equalTo(ratingButton)
            $0.width.height.equalTo(15)
        }
        
        filterStackView.snp.makeConstraints{
            $0.top.equalTo(lineView).inset(9)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(180)
        }
        
        cancelSortButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(10)
            $0.top.equalTo(lineView).inset(9)
            $0.height.width.equalTo(23)
        }
        
        goodsCollectionView.snp.makeConstraints {
            $0.top.equalTo(sortLabel.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 30, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GoodsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.goodsCellID, for: indexPath) as! GoodsCollectionViewCell
        cell.data = GoodsArray[indexPath.row]
        cell.delegate = self
        return cell
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

extension MainViewController: GoodsLoaderDelegate {
    func loaded(goodsInfo: [GoodsInfo]) {
//        print(goodsInfo)
        print(goodsInfo.first?.name)
        self.goodsInfoArray = goodsInfo
        print(self.goodsInfoArray)
//        goodsCollectionView.reloadData()
    }
    
    
}
