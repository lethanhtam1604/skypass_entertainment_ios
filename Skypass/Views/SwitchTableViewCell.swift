//
//  SwitchTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    let switchView = UISwitch()

    var constraintsAdded = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        selectionStyle = .none

        textLabel?.font = Global.lightFont(ip6(34))
        
        switchView.isOn = true
        switchView.isSelected = true
        switchView.setOn(true, animated: false)
        contentView.addSubview(switchView)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            switchView.autoPinEdge(toSuperviewMargin: .right)
            switchView.autoAlignAxis(toSuperviewAxis: .horizontal)
        }
    }
}
