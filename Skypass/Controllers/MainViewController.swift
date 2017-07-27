//
//  SignInViewController.swift
//  Maxi Unlock
//
//  Created by Luu Nguyen on 10/28/16.
//  Copyright © 2016 Lavamy. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    let mainView = MainView()
    
    var allNewEvents = [Event]()
    var allAppliedEvents = [Event]()
    var newEvents = [Event]()
    var appliedEvents = [Event]()
    
    var isSearching: Bool {
        return !(mainView.searchBar.text?.isEmpty ?? true)
    }
    
    var isNewEvents: Bool {
        return mainView.segmentControl.selectedSegmentIndex == 0
    }
    
    override func loadView() {
        view = mainView
        view.setNeedsUpdateConstraints()
    }
    
    override func viewDidLoad() {
        title = "Skypass"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png")?.resize(CGSize(20,20)),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(filter))
        
        #if Admin
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus.png")?.resize(CGSize(20,20)),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(addEvent))
        #endif
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        mainView.segmentControl.selectedSegmentIndex = 0
        mainView.segmentControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        
        mainView.searchBar.delegate = self
        mainView.searchBar.autocapitalizationType = .none
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.emptyDataSetSource = self
        mainView.collectionView.emptyDataSetDelegate = self
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshAppliedEvents()
    }
    
    func filter() {
        let filter = FilterViewController()
        navigationController?.pushViewController(filter, animated: true)
    }
    
    func addEvent() {
        let newEventVC = NewEventViewController()
        newEventVC.isNew = true
        navigationController?.pushViewController(newEventVC, animated: true)
    }
    
    func segmentValueChanged() {

        search()
    }
    
    func loadData() {
        mainView.indicator.startAnimating()
        DatabaseHelper.shared.getEvents() {
            events in
            
            // initialize
            
            self.allNewEvents = events
            self.refreshAppliedEvents()
            self.mainView.indicator.stopAnimating()

            
            // observe
            
            DatabaseHelper.shared.observeEvents() {
                event in
                
                self.allNewEvents.remove(event)
                self.allAppliedEvents.remove(event)
                self.allNewEvents.append(event)
                self.refreshAppliedEvents()
            }
        }
    }
    
    func refreshAppliedEvents() {
        let appliedIds = DatabaseHelper.shared.getAppliedEvents()
        var movedEvents = [Event]()
        
        for event in allNewEvents {
            if appliedIds.contains(event.id) {
                if !allAppliedEvents.contains(event) {
                    allAppliedEvents.append(event)
                    movedEvents.append(event)
                }
            }
        }
        
        for event in movedEvents {
            allNewEvents.remove(event)
        }
        
        search()
    }
    
    func search() {
        var source = isNewEvents ? allNewEvents : allAppliedEvents
        #if Admin
            source = allNewEvents

            // keep ended events
            if isNewEvents {
                for (_,event) in source.reversed().enumerated() {
                    if event.end {
                        source.remove(event)
                    }
                }
            }
            else {
                for (_,event) in source.reversed().enumerated() {
                    if !event.end {
                        source.remove(event)
                    }
                }
            }
        
        #else
            for (_,event) in source.reversed().enumerated() {
                if event.end {
                    source.remove(event)
                }
            }
        #endif
        
        let searchText = mainView.searchBar.text ?? ""
        var result = [Event]()
        
        if searchText.isEmpty {
            result.append(contentsOf: source)
        } else {
            let text = searchText.lowercased()
            
            for event in source {
                if (event.title.lowercased().contains(text)) ||
                    (event.info?.lowercased().contains(text) ?? false) {
                    result.append(event)
                }
            }
        }
        
        if isNewEvents {
            newEvents = sort(result)
        } else {
            appliedEvents = sort(result)
        }
        
        mainView.collectionView.reloadData()
    }
    
    func sort(_ events: [Event]) -> [Event] {
        switch Global.filter {
        case .name:
            return events.sorted() { $0.title.lowercased() < $1.title.lowercased() }
            
        case .date:
            let today = Date()
            
            return events.sorted() {
                e1, e2 in
                var d1: Date?
                var d2: Date?
                
                for location in e1.locations {
                    let d = location.datetime
                    if d != nil {
                        if d!.compare(today) != .orderedAscending {
                            if d1 == nil {
                                d1 = d
                            } else if d!.compare(d1!) == .orderedAscending {
                                d1 = d
                            }
                        }
                    }
                }
                
                for location in e2.locations {
                    let d = location.datetime
                    if d != nil {
                        if d!.compare(today) != .orderedAscending {
                            if d2 == nil {
                                d2 = d
                            } else if d!.compare(d2!) == .orderedAscending {
                                d2 = d
                            }
                        }
                    }
                }
                
                if d1 == nil {
                    return false
                }
                
                if d2 == nil {
                    return false
                }
                
                return d1!.compare(d2!) == .orderedAscending
            }
            
        case .defaut:
            return events.sorted() { $0.priority > $1.priority }
            
        }
    }
    
    
    // UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        search()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isNewEvents ? newEvents.count : appliedEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! EventCollectionViewCell
        cell.event = isNewEvents ? newEvents[indexPath.row] : appliedEvents[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventVC = EventViewController()
        eventVC.event = isNewEvents ? newEvents[indexPath.row] : appliedEvents[indexPath.row]
        navigationController?.pushViewController(eventVC, animated: true)
    }
    
    // empty set
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attrs = [NSForegroundColorAttributeName: Global.colorPrimary.alpha(0.5),
                     NSFontAttributeName: Global.font(20)]
        return NSAttributedString(string: "No event found", attributes: attrs)
    }
}
