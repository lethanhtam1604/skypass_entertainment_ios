//
//  ViewShot.swift
//  VISUALOGYX
//
//  Created by Luu Nguyen on 10/5/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit
import QuartzCore

let tagBorderBottom = 10

extension UIView {
    // shot
    
    func snapshot() -> UIImage {
        let size = self.frame.size
        let rect = CGRect(0, 0, size.width, size.height)
        
        UIGraphicsBeginImageContext(size)
        drawHierarchy(in: rect, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image == nil {
            fatalError("Snapshot is null")
        }
        
        return image!
    }

    // keyboard
    
    func addTapToDismiss() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
    }
    
    func dismiss() {
        endEditing(true)
    }
    
    // rotate
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        self.layer.add(animation, forKey: nil)
    }
}
