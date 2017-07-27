//
//  QuestionView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    let tableView = UITableView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBgDark
        
        tableView.backgroundColor = Global.colorBgDark
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.rowHeight = ip6(450)
        
        addSubview(tableView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            tableView.autoPinEdgesToSuperviewEdges()
        }
    }
}
