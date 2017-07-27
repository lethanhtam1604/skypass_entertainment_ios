
//
//  UserListView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class UserListView: UIView {
    let tableView = UITableView()
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBgDark
        
        tableView.backgroundColor = Global.colorBgDark
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = ip6(112)
        
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = Global.colorBg
        
        addSubview(tableView)
        addSubview(indicator)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            tableView.autoPinEdgesToSuperviewEdges()
            indicator.autoPinEdgesToSuperviewEdges()
        }
    }
}
