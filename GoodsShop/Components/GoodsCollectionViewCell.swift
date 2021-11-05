//
//  GoodsCollectionViewCell.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 05.11.2021.
//

import UIKit

class GoodsCollectionViewCell: UICollectionViewCell {
    
    var data: GoodsShowInfo? {
        didSet {
            guard let data = data else { return }
            imageView.image = data.image
            nameLabel.text = data.name
            descriptionLabel.text = data.description
            priceLabel.text = "\(data.price)"
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = .black
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 17)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 13)
        label.textColor = .black
        label.numberOfLines = 1
//        label.backgroundColor = .red
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 13)
        label.textColor = .black
        label.layer.borderColor = Colors.mainBlue.cgColor
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 8
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.plus, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupContraints() {
        
        for view in [imageView, nameLabel, descriptionLabel, priceLabel, plusButton] {
            contentView.addSubview(view)
        }
    
        self.layer.cornerRadius = 20
        self.backgroundColor = .systemGray2
        
        imageView.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(130)
            
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.left.equalToSuperview().inset(5)
            $0.right.equalToSuperview().offset(5)
            $0.height.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
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
