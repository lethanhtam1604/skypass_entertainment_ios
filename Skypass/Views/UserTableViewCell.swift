//
//  UserTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    let avatarImage = UIImageView(image: UIImage(named: "avatar.png"))
    let indicator = UIImageView(image: UIImage(named: "forward.png"))
    let titleLabel = UILabel()
    let separator = UIView()
    
    var constraintsAdded = false
    
    var user: User! {
        didSet {
            titleLabel.text = user.name
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
        clipsToBounds = true
        
        titleLabel.font = Global.font(ip6(34))
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.darkText
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        
        avatarImage.contentMode = .scaleAspectFit
        
        indicator.contentMode = .scaleAspectFit
        
        separator.backgroundColor = Global.colorBorder
        
        contentView.addSubview(avatarImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicator)
        contentView.addSubview(separator)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            avatarImage.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(20))
            avatarImage.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(10))
            avatarImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: ip6(0))
            avatarImage.autoSetDimension(.width, toSize: ip6(70))

            titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: ip6(110))
            titleLabel.autoPinEdge(toSuperviewMargin: .right)
            titleLabel.autoPinEdge(toSuperviewMargin: .top)
            titleLabel.autoPinEdge(toSuperviewMargin: .bottom)
            
            indicator.autoSetDimensions(to: CGSize(ip6(30),ip6(30)))
            indicator.autoAlignAxis(toSuperviewAxis: .horizontal)
            indicator.autoPinEdge(toSuperviewMargin: .right)
            
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoPinEdge(toSuperviewEdge: .bottom, withInset: px(1))
            separator.autoSetDimension(.height, toSize: px(1))
            separator.autoPinEdge(toSuperviewEdge: .left)
        }
    }
}
