//
//  IntroView.swift
//  Ricochet
//
//  Created by Luu Nguyen on 11/26/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit
import PureLayout

class MainView: UIView {
    let segmentView = UIView()
    var segmentControl = UISegmentedControl(items: ["New", "Applied"])
    let searchBar = UISearchBar()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var constraintsAdded = false
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = Global.colorBg
        
        segmentView.backgroundColor = Global.colorPrimary
        
        #if Admin
            segmentControl = UISegmentedControl(items: ["Active", "End"])
        #else
            segmentControl = UISegmentedControl(items: ["New", "Applied"])
        #endif

        segmentControl.tintColor = Global.colorBg
        segmentControl.setTitleTextAttributes([NSFontAttributeName: Global.font(ip6(28))], for: .normal)

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
        
        let p = ip6(25) / 2
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.indicatorStyle = .default
        collectionView.contentInset = UIEdgeInsetsMake(p, p, p, p)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(p, p, p, p)
        layout.minimumLineSpacing = p * 2
        
        let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 2 - p * 3
        layout.itemSize = CGSize(width: width, height: width * 1.8)

        segmentView.addSubview(segmentControl)
        
        indicator.hidesWhenStopped = true
        indicator.backgroundColor = Global.colorBg
        
        addSubview(segmentView)
        addSubview(searchBar)
        addSubview(collectionView)
        addSubview(indicator)
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !constraintsAdded {
            constraintsAdded = true
            
            segmentControl.autoCenterInSuperview()
            segmentControl.autoMatch(.width, to: .width, of: segmentView, withMultiplier: 0.5)
            
            segmentView.autoPinEdge(toSuperviewEdge: .left)
            segmentView.autoPinEdge(toSuperviewEdge: .right)
            segmentView.autoPinEdge(toSuperviewEdge: .top)
            segmentView.autoSetDimension(.height, toSize: ip6(100))
            
            searchBar.autoPinEdge(toSuperviewEdge: .left)
            searchBar.autoPinEdge(toSuperviewEdge: .right)
            searchBar.autoPinEdge(.top, to: .bottom, of: segmentView)
            searchBar.autoSetDimension(.height, toSize: ip6(100))
            
            collectionView.autoPinEdge(toSuperviewEdge: .left)
            collectionView.autoPinEdge(toSuperviewEdge: .right)
            collectionView.autoPinEdge(toSuperviewEdge: .bottom)
            collectionView.autoPinEdge(.top, to: .bottom, of: searchBar)
            
            indicator.autoPinEdge(toSuperviewEdge: .left)
            indicator.autoPinEdge(toSuperviewEdge: .right)
            indicator.autoPinEdge(toSuperviewEdge: .bottom)
            indicator.autoPinEdge(.top, to: .bottom, of: segmentView)
        }
    }
}
