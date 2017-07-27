//
//  DisclaimerView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class DisclaimerView: UIView {
    let infoView = UITextView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        infoView.tintColor = Global.colorPrimary
        infoView.isEditable = false
        infoView.backgroundColor = Global.colorBg
        infoView.font = Global.lightFont(ip6(30))
        infoView.textAlignment = .left
        infoView.textColor = UIColor.black
        infoView.textContainerInset = UIEdgeInsetsMake(ip6(15), ip6(15), ip6(15), ip6(15))
        
        addSubview(infoView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            infoView.autoPinEdgesToSuperviewEdges()
        }
    }
}
