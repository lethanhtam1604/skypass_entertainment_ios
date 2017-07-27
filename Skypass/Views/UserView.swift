//
//  UserView.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/6/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import PureLayout

class UserView: UIView {
    let scrollView = UIScrollView()
    let containerView = UIView()
    let infoTable = UITableView()
    let questionTable = UITableView()
    
    var constraintsAdded = false
    var constraintInfoHeight: NSLayoutConstraint?
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        backgroundColor = Global.colorBg
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        
        infoTable.backgroundColor = Global.colorBg
        infoTable.separatorStyle = .none
        infoTable.bounces = false
        infoTable.register(FieldTableViewCell.self, forCellReuseIdentifier: "cell")
        infoTable.tableFooterView = UIView()
        infoTable.rowHeight = ip6(100)
        infoTable.allowsSelection = false
        infoTable.showsVerticalScrollIndicator = false
        infoTable.showsHorizontalScrollIndicator = false
        
        questionTable.backgroundColor = Global.colorBgDark
        questionTable.separatorStyle = .none
        questionTable.bounces = false
        questionTable.register(QuestionTableViewCell.self, forCellReuseIdentifier: "cell")
        questionTable.tableFooterView = UIView()
        questionTable.rowHeight = ip6(450)
        questionTable.allowsSelection = false
        questionTable.showsVerticalScrollIndicator = false
        questionTable.showsHorizontalScrollIndicator = false

        containerView.addSubview(infoTable)
        containerView.addSubview(questionTable)
        scrollView.addSubview(containerView)
        addSubview(scrollView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            scrollView.autoPinEdgesToSuperviewEdges()

            infoTable.autoPinEdge(toSuperviewMargin: .left)
            infoTable.autoPinEdge(toSuperviewMargin: .right)
            infoTable.autoPinEdge(toSuperviewEdge: .top, withInset: ip6(25))
            constraintInfoHeight = infoTable.autoSetDimension(.height, toSize: 0)

            questionTable.autoPinEdge(toSuperviewEdge: .left)
            questionTable.autoPinEdge(toSuperviewEdge: .right)
            questionTable.autoPinEdge(toSuperviewEdge: .bottom)
            questionTable.autoPinEdge(.top, to: .bottom, of: infoTable, withOffset: 10)
        }
    }
}
