//
//  FilterTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let checkMark = UIImageView(image: UIImage(named: "checkmark.png"))
    let separator = UIView()
    
    var constraintsAdded = false
    var constraintMargin: NSLayoutConstraint?
    var constraintEdge: NSLayoutConstraint?

    var filterType: FilterType! {
        didSet {
            titleLabel.text = filterType.toString()
        }
    }

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

        titleLabel.font = Global.font(ip6(34))
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.darkText
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1

        checkMark.contentMode = .scaleAspectFit
        
        separator.backgroundColor = Global.colorBorder

        contentView.addSubview(titleLabel)
        contentView.addSubview(checkMark)
        contentView.addSubview(separator)

        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            titleLabel.autoPinEdge(toSuperviewMargin: .left)
            titleLabel.autoPinEdge(toSuperviewMargin: .right)
            titleLabel.autoPinEdge(toSuperviewMargin: .top)
            titleLabel.autoPinEdge(toSuperviewMargin: .bottom)
            
            checkMark.autoSetDimensions(to: CGSize(ip6(30),ip6(30)))
            checkMark.autoAlignAxis(toSuperviewAxis: .horizontal)
            checkMark.autoPinEdge(toSuperviewMargin: .right)
            
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoPinEdge(toSuperviewEdge: .bottom)
            separator.autoSetDimension(.height, toSize: px(1))
            
            constraintMargin = separator.autoPinEdge(toSuperviewMargin: .left)
            constraintEdge = separator.autoPinEdge(toSuperviewEdge: .left)
        }
        
        if filterType.rawValue == FilterType.count - 1 {
            constraintMargin?.isActive = false
            constraintEdge?.isActive = true
        } else {
            constraintMargin?.isActive = true
            constraintEdge?.isActive = false
        }
    }
}
