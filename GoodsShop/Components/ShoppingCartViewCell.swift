//
//  ShoppingCartViewCell.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 16.11.2021.
//

import Foundation
import UIKit

class ShoppingCartViewCell: UICollectionViewCell {
    
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints() {
        
        for ui in [imageView, nameLabel, descriptionLabel, priceLabel] {
            self.addSubview(ui)
        }
        
    }

    
}
