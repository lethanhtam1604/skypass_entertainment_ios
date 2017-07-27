//
//  FilterView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class FilterView: UIView {
    let tableView = UITableView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBgDark

        tableView.backgroundColor = Global.colorBgDark
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = ip6(110)
        
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            tableView.autoPinEdgesToSuperviewEdges()
        }
    }
}
