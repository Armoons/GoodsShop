//
//  LineUnderBrandLabel.swift
//  GoodsShop
//
//  Created by Stepanyan Arman  on 04.11.2021.
//

import UIKit

class LineUnderBrandLabel: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.lineWidth = 2
        aPath.move(to: CGPoint(x:0, y:0))
        aPath.addLine(to: CGPoint(x:self.frame.width, y:0))
        aPath.close()
        Colors.mainBlue.set()
        aPath.stroke()
        aPath.fill()
    }
}
