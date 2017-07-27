//
//  LocationView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class LocationView: UIView {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBg
        
        let attrs = [NSFontAttributeName: Global.font(ip6(28))]
        
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search"
        searchBar.tintColor = Global.colorPrimary
        searchBar.barTintColor = Global.colorBgDark
        searchBar.backgroundColor = Global.colorBgDark
        searchBar.textField.backgroundColor = Global.colorBgDark
        searchBar.textField.font = Global.font(ip6(28))
        searchBar.textField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attrs)
        searchBar.layer.borderColor = Global.colorBgDark.cgColor
        searchBar.layer.borderWidth = 1
        
        tableView.backgroundColor = Global.colorBgDark
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.register(EventLocationTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = ip6(150)
        tableView.allowsSelection = true
        
        addSubview(searchBar)
        addSubview(tableView)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            searchBar.autoPinEdge(toSuperviewEdge: .left)
            searchBar.autoPinEdge(toSuperviewEdge: .right)
            searchBar.autoPinEdge(toSuperviewEdge: .top)
            searchBar.autoSetDimension(.height, toSize: ip6(100))
            
            tableView.autoPinEdge(toSuperviewEdge: .left)
            tableView.autoPinEdge(toSuperviewEdge: .right)
            tableView.autoPinEdge(toSuperviewEdge: .bottom)
            tableView.autoPinEdge(.top, to: .bottom, of: searchBar)
        }
    }
}
