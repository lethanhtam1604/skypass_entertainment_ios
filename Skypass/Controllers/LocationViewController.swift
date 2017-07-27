//
//  LocationViewController.swift
//  RSS
//
//  Created by Thanh-Tam Le on 3/22/17.
//  Copyright © 2017 Lavamy. All rights reserved.
//

import UIKit
import PureLayout
import DZNEmptyDataSet
import GooglePlaces

protocol LocationDelegate:class {
    func locationDidChange(_ location: Location?)
}

class LocationViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, GMSAutocompleteFetcherDelegate {
    let locationView = LocationView()
    
    var fetcher: GMSAutocompleteFetcher?
    var locations = [Location]()
    weak var delegate: LocationDelegate?
    
    override func loadView() {
        view = locationView
        view.setNeedsUpdateConstraints()
    }
    
    deinit {
        delegate = nil
    }
    
    override func viewDidLoad() {
        title = "Location"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //enable swipe back when it changed leftBarButtonItem
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        locationView.searchBar.delegate = self
        locationView.searchBar.autocapitalizationType = .none
        
        locationView.tableView.delegate = self
        locationView.tableView.dataSource = self
        locationView.tableView.emptyDataSetSource = self
        locationView.tableView.delegate = self

        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        fetcher = GMSAutocompleteFetcher(bounds: nil, filter: filter)
        fetcher?.delegate = self
    }
    
    func cancel() {
        delegate?.locationDidChange(nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    // UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetcher?.sourceTextHasChanged(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        locations.removeAll()
        locationView.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EventLocationTableViewCell
        cell.location = locations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        delegate?.locationDidChange(location)
        _ = navigationController?.popViewController(animated: true)
    }
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        return NSAttributedString(string: "No location found", attributes: attrs)
    }
    
    // fetcher
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        locations.removeAll()
        
        for prediction in predictions {
            let location = Location()
            location.location = prediction.attributedPrimaryText.string
            location.desc = prediction.attributedSecondaryText?.string
            location.fullAddress = prediction.attributedFullText.string
            locations.append(location)
        }
        
        locationView.tableView.reloadData()
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        locations.removeAll()
        locationView.tableView.reloadData()
    }
}
