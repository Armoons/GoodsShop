//
//  GoodsCollectionViewCell.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 05.11.2021.
//

import UIKit
import Kingfisher

protocol GoodsCollectionViewCellDelegate {
    func didAddNewGoods()
    func didRemovedGoods()
}

class GoodsCollectionViewCell: UICollectionViewCell {
    
    var delegate: GoodsCollectionViewCellDelegate?
    
    var data: GoodsInfo? {
        didSet {
            guard let data = data else { return }
            let imageURL = URL(string: data.image)
            imageView.kf.setImage(with: imageURL)
            nameLabel.text = data.name
            priceLabel.text = "\(data.price)₽"
            
            if data.name.count == 7 {
                let text = String(data.desc.replacingOccurrences(of: "<h3>Товар 1<h3><p>", with: "").dropLast(2))
                descriptionLabel.text = text
            } else {
                let text = String(data.desc.dropFirst(data.name.count + 10).dropLast(2))
                descriptionLabel.text = text
            }
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 17)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 13)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 13)
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderColor = Colors.mainBlue.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.plusBlack, for: .normal)
        button.addTarget(self, action: #selector(plusTouched), for: .touchUpInside)

        return button
    }()
    private var didPlusTouch: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func plusTouched(){
        
        if !didPlusTouch {
            delegate?.didAddNewGoods()
            UIView.animate(withDuration: 0.3, delay: 0){
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
                self.priceLabel.layer.backgroundColor = Colors.mainBlue.cgColor
                self.priceLabel.textColor = .white
            }
            selectedGoods.array.append(data!)
        } else {
            delegate?.didRemovedGoods()
            UIView.animate(withDuration: 0.3, delay: 0){
                self.plusButton.transform = CGAffineTransform(rotationAngle: 0)
                self.priceLabel.layer.backgroundColor = .none
                self.priceLabel.textColor = .black
            }
            selectedGoods.array.removeAll {
                $0.id == data?.id
            }
        }
        didPlusTouch = !didPlusTouch
    }
    
    private func setupContraints() {
        
        for view in [imageView, nameLabel, descriptionLabel, priceLabel, plusButton] {
            contentView.addSubview(view)
        }
        
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.mainBlue.cgColor
            
        imageView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(5)
            $0.right.equalToSuperview().offset(5)
            $0.height.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(5)
            $0.height.equalTo(20)
        }
        
        priceLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.width.equalTo(72)
            $0.height.equalTo(21)
        }
        
        plusButton.snp.makeConstraints{
            $0.left.equalTo(priceLabel.snp.right).offset(10)
            $0.height.width.equalTo(21)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
