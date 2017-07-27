//
//  CGRect.swift
//  Maxi Unlock
//
//  Created by Luu Nguyen on 10/28/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import CoreGraphics

extension CGRect{
    init(_ x:CGFloat, _ y:CGFloat, _ width:CGFloat, _ height:CGFloat) {
        self.init(x:x, y:y, width:width, height:height)
    }
 
    mutating func offsetInPlace(dx: CGFloat, dy: CGFloat) {
        self = self.offsetBy(dx: dx, dy: dy)
    }
}
