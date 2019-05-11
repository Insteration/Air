//
//  Extensions.swift
//  Air
//
//  Created by Art Karma on 5/11/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

extension CGRect {
    
    var end: CGPoint {
        return CGPoint(x: origin.x + size.width, y: origin.y + size.height)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: origin.x + size.width, y: origin.y)
    }
    
    var botLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height)
    }
    
}


extension NSCopying {
    
    var string: String {
        return self as! String
    }
    
}
