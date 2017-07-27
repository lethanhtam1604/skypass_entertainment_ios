//
//  FilterViewController.swift
//  Skypass
//
//  Created by Luu Nguyen on 4/5/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let filterView = FilterView()
    
    var selectedFilter = Global.filter
    
    override func loadView() {
        view = filterView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(applyFilter))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white

        filterView.tableView.delegate = self
        filterView.tableView.dataSource = self
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filterView.tableView.reloadData()
    }
    
    func applyFilter() {
        Global.filter = selectedFilter
        _ = navigationController?.popViewController(animated: true)
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterTableViewCell
        cell.filterType = FilterType(rawValue: indexPath.row)!
        cell.checkMark.isHidden = cell.filterType.rawValue != selectedFilter.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilter = FilterType(rawValue: indexPath.row)!
        tableView.reloadData()
    }
    
}
