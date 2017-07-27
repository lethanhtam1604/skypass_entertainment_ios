//
//  NewLocationView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/14/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class NewLocationView: UIView {
    let tableView = UITableView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBg
        
        tableView.backgroundColor = Global.colorBg
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")
        
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
