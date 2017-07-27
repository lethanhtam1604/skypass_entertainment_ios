//
//  NewDisclaimerView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class NewDisclaimerView: UIView {
    let infoLabel = UILabel()
    let infoView = KMPlaceholderTextView()
    let separator = UIView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        infoLabel.font = Global.font(ip6(38))
        infoLabel.textAlignment = .left
        infoLabel.textColor = Global.colorPrimary
        infoLabel.adjustsFontSizeToFitWidth = false
        infoLabel.numberOfLines = 1
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.text = "Please provide disclaimer for event?"
        
        infoView.tintColor = Global.colorPrimary
        infoView.isEditable = true
        infoView.backgroundColor = Global.colorBg
        infoView.font = Global.lightFont(ip6(30))
        infoView.textAlignment = .left
        infoView.textColor = UIColor.black
        infoView.textContainerInset = UIEdgeInsetsMake(ip6(15), ip6(15), ip6(15), ip6(15))
        infoView.placeholder = "Enter your text here..."
        
        separator.backgroundColor = Global.colorBorder
        
        addSubview(infoLabel)
        addSubview(separator)
        addSubview(infoView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            infoLabel.autoPinEdge(toSuperviewMargin: .left)
            infoLabel.autoPinEdge(toSuperviewMargin: .right)
            infoLabel.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(00))
            infoLabel.autoSetDimension(.height, toSize: ip6(120))
            
            separator.autoPinEdge(toSuperviewEdge: .left)
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoSetDimension(.height, toSize: px(1))
            separator.autoPinEdge(.top, to: .bottom, of: infoLabel)
            
            infoView.autoPinEdge(toSuperviewEdge: .left)
            infoView.autoPinEdge(toSuperviewEdge: .right)
            infoView.autoPinEdge(toSuperviewEdge: .bottom)
            infoView.autoPinEdge(.top, to: .bottom, of: separator)
        }
    }
}
