//
//  ShoppingCartTableCell.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 30.11.2021.
//

import Foundation
import UIKit
import Kingfisher

protocol ShoppingCartTableCellDelegate {
    func plusTouched(id: String)
    func minusTouched(id: String)
}

class ShoppingCartTableCell: UITableViewCell {
    
    var data: GoodsInfo? {
        didSet {
            guard let data = data else { return }
            let imageURL = URL(string: data.image)
            imageV.kf.setImage(with: imageURL)
            nameLabel.text = data.name
            priceLabel.text = "\(data.price)₽"
            
            
            if data.name.count == 7 {
                let text = String(data.desc.replacingOccurrences(of: "<h3>Товар 1<h3><p>", with: "").dropLast(4))
                descriptionLabel.text = text
            } else {
                let text = String(data.desc.dropFirst(data.name.count + 10).dropLast(4))
                descriptionLabel.text = text
            }
        }
    }
    
    var delegate: ShoppingCartTableCellDelegate?
    
    private let imageV: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let nameLabel: UILabel = {
        $0.font = UIFont(name: Font.sfBold, size: 17)
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfLight, size: 13)
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 18)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let changeNumberButton = CartChangeNumberButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraints() {
        
        
        
        changeNumberButton.delegate = self
        self.backgroundColor = Colors.background
        for ui in [imageV, nameLabel, descriptionLabel, priceLabel, changeNumberButton] {
            contentView.addSubview(ui)
        }
        
        
        imageV.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().inset(12)
            $0.left.equalToSuperview().inset(10)
            $0.width.equalTo(180)
        }
        
        nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(12)
            $0.left.equalTo(imageV.snp.right).offset(12)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageV.snp.right).offset(12)
            $0.right.equalToSuperview().inset(20)
        }
        
        priceLabel.snp.makeConstraints{
            $0.left.equalTo(imageV.snp.right).offset(12)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        
        changeNumberButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(85)
            $0.height.equalTo(25)
            
        }
    }
}

extension ShoppingCartTableCell: CartChangeNumberButtonDelegate {
    
    func plusTouched() {
        delegate?.plusTouched(id: data?.id ?? "")
    }
    
    func minusTouched() {
        delegate?.minusTouched(id: data?.id ?? "")
    }
    
    
}
