//
//  FormView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import M13Checkbox
import ActiveLabel

class FormView: UIView {
    let tableView = UITableView()
    let footerView = UIView()
    let checkBox = M13Checkbox()
    let activeLabel = ActiveLabel()
    let customType = ActiveType.custom(pattern: "\\sdisclaimer\\b")
    let warningLabel = UILabel()

    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBg
        
        tableView.backgroundColor = Global.colorBg
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.tableFooterView = footerView
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        checkBox.markType = .checkmark
        checkBox.boxType = .square
        checkBox.tintColor = UIColor(0x167efb)
        checkBox.checkState = .checked
        checkBox.stateChangeAnimation = .fill
        checkBox.cornerRadius = 0
        
        activeLabel.enabledTypes = [customType]
        activeLabel.customColor[customType] = UIColor(0x1a3281)
        activeLabel.customSelectedColor[customType] = UIColor(0x1a3281)
        activeLabel.text = "I agree that I read this disclaimer."
        activeLabel.font = Global.lightFont(ip6(30))

        warningLabel.text = "*Information provided must be valid and Name and Birthday must match Driver's License or Passport."
        warningLabel.font = Global.lightFont(ip6(20))
        warningLabel.textColor = Global.colorPrimary.alpha(0.8)
        warningLabel.lineBreakMode = .byWordWrapping
        warningLabel.numberOfLines = 0
        
        footerView.addSubview(checkBox)
        footerView.addSubview(activeLabel)
        footerView.addSubview(warningLabel)

        footerView.frame = CGRect(0,0,UIScreen.main.bounds.width, ip6(200))
        checkBox.frame = CGRect(ip6(0),ip6(30),ip6(40),ip6(40))
        activeLabel.frame = CGRect(ip6(50),ip6(0),UIScreen.main.bounds.width, ip6(100))
        warningLabel.frame = CGRect(0,ip6(70),UIScreen.main.bounds.width - ip6(50), ip6(100))

        addSubview(tableView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            tableView.autoPinEdge(toSuperviewMargin: .left)
            tableView.autoPinEdge(toSuperviewMargin: .right)
            tableView.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(20))
            tableView.autoPinEdge(toSuperviewEdge: .bottom, withInset: ip6(20))
        }
    }
}
