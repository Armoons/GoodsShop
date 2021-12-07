//
//  LineUnderBrandLabel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit
import SnapKit


class HeaderOfView: UIView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.sfBold, size: 26)
        return label
    }()
    
    private let lineView: LineUnderBrandLabel = {
        let view = LineUnderBrandLabel()
        view.backgroundColor = Colors.mainBlue
        return view
    }()
    
    convenience init(headerText: String) {
        self.init(frame: CGRect.zero)
        headerLabel.text = headerText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        for ui in [lineView, headerLabel] {
            self.addSubview(ui)
        }
        
        headerLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
            $0.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints{
            $0.top.equalTo(headerLabel.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}
