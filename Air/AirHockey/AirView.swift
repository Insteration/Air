//
//  AirView.swift
//  Air
//
//  Created by Art Karma on 5/11/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class AirRoundView: UIView {
    
    var color = UIColor.black {
        didSet { setNeedsLayout() }
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .path
    }
    
    override var collisionBoundingPath: UIBezierPath {
        let rad = min(bounds.size.width, bounds.size.height) / 2
        return UIBezierPath(arcCenter: .zero, radius: rad, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
    }
    
    private var shapeLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.clear.cgColor
            layer.addSublayer(shapeLayer)
        }
        
        let rad = min(bounds.size.width, bounds.size.height) / 2
        
        shapeLayer.fillColor = color.cgColor
        shapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0), radius: rad, startAngle: 0, endAngle: CGFloat(.pi * 2.0), clockwise: true).cgPath
    }
}
