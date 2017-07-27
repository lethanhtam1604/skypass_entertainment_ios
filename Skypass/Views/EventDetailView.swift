//
//  EventDetailView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class EventDetailView: UIView {
    let infoLabel = UILabel()
    let infoView = UITextView()
    let separator = UIView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        infoLabel.font = Global.font(ip6(26))
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.darkText
        infoLabel.adjustsFontSizeToFitWidth = false
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.text = "DESCRIPTION"

        infoView.tintColor = Global.colorPrimary
        infoView.isEditable = false
        infoView.backgroundColor = Global.colorBg
        infoView.font = Global.lightFont(ip6(30))
        infoView.textAlignment = .left
        infoView.textColor = UIColor.black
        infoView.textContainerInset = UIEdgeInsetsMake(ip6(15), ip6(15), ip6(15), ip6(15))
        
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
            infoLabel.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(20))
            infoLabel.autoSetDimension(.height, toSize: ip6(80))
            
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
