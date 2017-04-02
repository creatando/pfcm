//
//  LoadTacticViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 26/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView
import PKHUD

class LoadTacticViewController: UITableViewController {
    
    let realm = try! Realm()
    var results = try! Realm().objects(Tactic.self).sorted(byKeyPath: "date",  ascending: false)
    var searchResults = try! Realm().objects(Tactic.self).sorted(byKeyPath: "date",  ascending: false)
    var searchController: UISearchController!
    var tacticName: String?
    var date: String?
    
    var gkCoord: [Double]?
    var p2Coord: [Double]?
    var p3Coord: [Double]?
    var p4Coord: [Double]?
    var p5Coord: [Double]?
    var p6Coord: [Double]?
    var p7Coord: [Double]?
    var p8Coord: [Double]?
    var p9Coord: [Double]?
    var p10Coord: [Double]?
    var p11Coord: [Double]?
    
    var annotationLink: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupSearch() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.white
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.placeholder = ""
        searchController.preferredContentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        searchController.hidesNavigationBarDuringPresentation = false
        
        //definesPresentationContext = true
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        searchController.searchBar.showsCancelButton = false
        
    }
    
    func filterResultsWithSearchString(searchString: String) {
        let realm = try! Realm()
        
        let predicaten = NSPredicate(format: "tacticName contains[c] %@", searchString)
        let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicaten])
        print ("predicate set")
        searchResults = realm.objects(Tactic.self).filter(predicateCompound).sorted(byKeyPath: "date", ascending: true)
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

   
    @IBAction func selectTactic(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let confirmAlertView = SCLAlertView(appearance: appearance)
        
        confirmAlertView.addButton("Yes") {
            lgkCoord = CGPoint(x: self.gkCoord!.first!, y: self.gkCoord!.last!)
            lp2Coord = CGPoint(x: self.p2Coord!.first!, y:self.p2Coord!.last!)
            lp3Coord = CGPoint(x: self.p3Coord!.first!, y: self.p3Coord!.last!)
            
            lp4Coord = CGPoint(x: self.p4Coord!.first!, y: self.p4Coord!.last!)
            lp5Coord = CGPoint(x: self.p5Coord!.first!, y: self.p5Coord!.last!)
            lp6Coord = CGPoint(x: self.p6Coord!.first!, y: self.p6Coord!.last!)
            lp7Coord = CGPoint(x: self.p7Coord!.first!, y: self.p7Coord!.last!)
            lp8Coord = CGPoint(x: self.p8Coord!.first!, y: self.p8Coord!.last!)
            lp9Coord = CGPoint(x: self.p9Coord!.first!, y: self.p9Coord!.last!)
            lp10Coord = CGPoint(x: self.p10Coord!.first!, y: self.p10Coord!.last!)
            lp11Coord = CGPoint(x: self.p11Coord!.first!, y: self.p11Coord!.last!)
            
            lannotationLink = self.annotationLink
            
            loadTactic = true
            
            self.dismiss(animated: true, completion: nil)
            HUD.flash(HUDContentType.label("Loading tactic..."), delay: 1.0)
    }

        
        confirmAlertView.addButton("No") {
            
        }
            confirmAlertView.showInfo("Select Tactic?", subTitle: "Select \(tacticName!)?")
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchController.isActive ? searchResults.count : results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loadTactic", for: indexPath) as! CustomTacticTableViewCell
        let object = searchController.isActive ? searchResults[indexPath.item] : results[indexPath.item]
        cell.name.text = object.tacticName
        cell.date.text = object.date.toString()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : Tactic = searchController.isActive ? searchResults[indexPath.item] : results[indexPath.row]
        gkCoord = selectedCell.gkCoord
        print(selectedCell.gkCoord.first!)
        print(selectedCell.gkCoord.last!)
        p2Coord = selectedCell.p2Coord
        p3Coord = selectedCell.p3Coord
        p4Coord = selectedCell.p4Coord
        p5Coord = selectedCell.p5Coord
        p6Coord = selectedCell.p6Coord
        p7Coord = selectedCell.p7Coord
        p8Coord = selectedCell.p8Coord
        p9Coord = selectedCell.p9Coord
        p10Coord = selectedCell.p10Coord
        p11Coord = selectedCell.p11Coord
        annotationLink = selectedCell.annotationLink
        tacticName = selectedCell.tacticName
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let selectedCell : Tactic = searchController.isActive ? searchResults[indexPath.item] : results[indexPath.row]
        
        if editingStyle == .delete {
           
            let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
            let confirmAlertView = SCLAlertView(appearance: appearance)
            
            confirmAlertView.addButton("Yes") {
                
                try! self.realm.write {
                    self.realm.delete(selectedCell)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                
            }
            confirmAlertView.addButton("No") {
            
            }
            confirmAlertView.showInfo("Clear?", subTitle: "Are you sure you want to delete this tactic?")
            
        }
    }


}

// MARK: - UISearchResultsUpdating
extension LoadTacticViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        print ("searching...")
        filterResultsWithSearchString(searchString: searchString)
        tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension LoadTacticViewController:  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension NSDate {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self as Date)
    }
}
