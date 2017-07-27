//
//  EventView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class EventView: UIView {
    let scrollView = UIScrollView()
    let containerView = UIView()
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let infoLabel = UILabel()
    let moreButton = UIButton()
    let applyButton = UIButton()
    let endButton = UIButton()
    let userButton = UIButton()
    let locationLabel = UILabel()
    let tableView = UITableView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        
        titleLabel.font = Global.semiboldFont(ip6(36))
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.black
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.lightGray
        imageView.sd_setShowActivityIndicatorView(true)
        
        infoLabel.font = Global.lightFont(ip6(32.07))
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.darkText
        infoLabel.adjustsFontSizeToFitWidth = false
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping

        moreButton.setImage(UIImage(named: "forward"), for: .normal)
        moreButton.imageView?.contentMode = .scaleAspectFit
        
        applyButton.setTitle("Sign Up", for: .normal)
        applyButton.setTitleColor(UIColor.white, for: .normal)
        applyButton.setTitleColor(UIColor.white.alpha(0.2), for: .highlighted)
        applyButton.setTitleColor(UIColor.white, for: .disabled)
        applyButton.layer.cornerRadius = 5
        applyButton.backgroundColor = Global.colorButton
        applyButton.titleLabel?.font = Global.font(ip6(32))
        
        endButton.setTitle("End", for: .normal)
        endButton.setTitleColor(UIColor.white, for: .normal)
        endButton.setTitleColor(UIColor.white.alpha(0.2), for: .highlighted)
        endButton.layer.cornerRadius = 5
        endButton.backgroundColor = Global.colorButton
        endButton.titleLabel?.font = Global.font(ip6(32))
        
        userButton.setTitle("Users", for: .normal)
        userButton.setTitleColor(Global.colorButton, for: .normal)
        userButton.setTitleColor(Global.colorButton.alpha(0.2), for: .highlighted)
        userButton.layer.borderColor = Global.colorButton.cgColor
        userButton.layer.cornerRadius = 5
        userButton.layer.borderWidth = 1
        userButton.backgroundColor = UIColor.clear
        userButton.titleLabel?.font = Global.font(ip6(32))
        
        locationLabel.font = Global.font(ip6(26))
        locationLabel.textAlignment = .left
        locationLabel.textColor = UIColor.darkText
        locationLabel.adjustsFontSizeToFitWidth = false
        locationLabel.numberOfLines = 1
        locationLabel.lineBreakMode = .byWordWrapping
        locationLabel.text = "LOCATIONS"

        tableView.backgroundColor = Global.colorBg
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(EventLocationTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = ip6(150)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)
        containerView.addSubview(infoLabel)
        containerView.addSubview(moreButton)
        containerView.addSubview(applyButton)
        containerView.addSubview(endButton)
        containerView.addSubview(userButton)
        containerView.addSubview(locationLabel)
        containerView.addSubview(tableView)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            scrollView.autoPinEdgesToSuperviewEdges()
            
            titleLabel.autoPinEdge(toSuperviewMargin: .left)
            titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(25))
            
            imageView.autoPinEdge(toSuperviewMargin: .left)
            imageView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: ip6(25))
            imageView.autoMatch(.width, to: .width, of: self, withMultiplier: 0.4)
            imageView.autoMatch(.height, to: .width, of: imageView, withMultiplier: 1.4)
            
            moreButton.autoPinEdge(toSuperviewMargin: .right)
            moreButton.autoSetDimensions(to: CGSize(ip6(32),ip6(32)))
            moreButton.autoAlignAxis(.horizontal, toSameAxisOf: imageView)
            
            infoLabel.autoPinEdge(.top, to: .top, of: imageView)
            infoLabel.autoPinEdge(.bottom, to: .bottom, of: imageView)
            infoLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: ip6(26))
            infoLabel.autoPinEdge(.right, to: .left, of: moreButton, withOffset: ip6(5))
            
            applyButton.autoPinEdge(toSuperviewMargin: .left)
            applyButton.autoPinEdge(toSuperviewMargin: .right)
            applyButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: ip6(20))
            applyButton.autoSetDimension(.height, toSize: ip6(90))
            
            endButton.autoPinEdge(toSuperviewMargin: .left)
            endButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: ip6(20))
            endButton.autoSetDimension(.height, toSize: ip6(90))
            
            userButton.autoPinEdge(toSuperviewMargin: .right)
            userButton.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: ip6(20))
            userButton.autoSetDimension(.height, toSize: ip6(90))
            
            userButton.autoMatch(.width, to: .width, of: endButton)
            userButton.autoPinEdge(.left, to: .right, of: endButton, withOffset: ip6(20))
            
            locationLabel.autoPinEdge(toSuperviewMargin: .left)
            locationLabel.autoPinEdge(.top, to: .bottom, of: applyButton, withOffset: ip6(20))
            locationLabel.autoSetDimension(.height, toSize: ip6(60))

            tableView.autoPinEdge(toSuperviewEdge: .left)
            tableView.autoPinEdge(toSuperviewEdge: .right)
            tableView.autoPinEdge(toSuperviewEdge: .bottom)
            tableView.autoPinEdge(.top, to: .bottom, of: locationLabel)
        }
    }
}
