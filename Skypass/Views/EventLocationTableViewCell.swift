//
//  LocationTableViewCell.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class EventLocationTableViewCell: UITableViewCell {
    let locationLabel = UILabel()
    let descLabel = UILabel()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let separator = UIView()

    static let dateFormatter = {
        () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter
    }()
    
    static let timeFormatter = {
        () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss a"
        return dateFormatter
    }()
    
    var constraintsAdded = false
    
    var location: Location! {
        didSet {
            locationLabel.text = location.location
            descLabel.text = location.desc
            dateLabel.text = location.date?.dateString
            timeLabel.text = location.time?.timeString
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
        
        separator.backgroundColor = Global.colorBorder
        
        locationLabel.font = Global.font(ip6(34))
        locationLabel.textAlignment = .left
        locationLabel.textColor = UIColor.darkText
        locationLabel.lineBreakMode = .byTruncatingTail
        locationLabel.numberOfLines = 1
        
        descLabel.font = Global.font(ip6(26))
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.darkText
        descLabel.lineBreakMode = .byTruncatingTail
        descLabel.numberOfLines = 1
        
        dateLabel.font = Global.font(ip6(30))
        dateLabel.textAlignment = .right
        dateLabel.textColor = UIColor.darkText
        dateLabel.lineBreakMode = .byTruncatingTail
        dateLabel.numberOfLines = 1
        
        timeLabel.font = Global.font(ip6(26))
        timeLabel.textAlignment = .right
        timeLabel.textColor = UIColor.darkText
        timeLabel.lineBreakMode = .byTruncatingTail
        timeLabel.numberOfLines = 1
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(separator)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true

            locationLabel.autoPinEdge(toSuperviewMargin: .left)
            locationLabel.autoPinEdge(toSuperviewMargin: .right)
            locationLabel.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withMultiplier: 0.7)
            
            descLabel.autoPinEdge(toSuperviewMargin: .left)
            descLabel.autoPinEdge(toSuperviewMargin: .right)
            descLabel.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withMultiplier: 1.3)
            
            dateLabel.autoPinEdge(toSuperviewMargin: .left)
            dateLabel.autoPinEdge(toSuperviewMargin: .right)
            dateLabel.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withMultiplier: 0.7)
            
            timeLabel.autoPinEdge(toSuperviewMargin: .left)
            timeLabel.autoPinEdge(toSuperviewMargin: .right)
            timeLabel.autoAlignAxis(.horizontal, toSameAxisOf: contentView, withMultiplier: 1.3)
            
            separator.autoPinEdge(toSuperviewEdge: .right)
            separator.autoPinEdge(toSuperviewEdge: .left)
            separator.autoPinEdge(toSuperviewEdge: .top)
            separator.autoSetDimension(.height, toSize: px(1))
        }
    }
}
