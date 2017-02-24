//
//  ViewPlayerController.swift
//  PFCM
//
//  Created by Thomas Anderson on 14/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import RealmSwift
import SCLAlertView
import Hue

class ViewPlayersController: UITableViewController {
    
    
    

    @IBAction func backNav(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    let realm = try! Realm()
    var results = try! Realm().objects(Player.self).sorted(byKeyPath: "lastName",  ascending: true)
    var searchResults = try! Realm().objects(Player.self).sorted(byKeyPath: "lastName",  ascending: true)
    var searchController: UISearchController!
    var playerID: String?
    var savedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        searchController.loadViewIfNeeded()
        self.tableView.reloadData()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    @IBAction func selectButton(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        let alertView = SCLAlertView(appearance: appearance)
        
        alertView.addButton("View") {
            self.performSegue(withIdentifier: "EPS", sender: self)
        }
        
        alertView.addButton("Edit") {
            print("Edit button tapped")
            self.performSegue(withIdentifier: "EPS", sender: self)
        }
        if self.playerID != nil{
        alertView.showNotice("View/Edit", subTitle: "Select whether you would like to view or edit the player.")
        }
    }
    
    func setupSearch() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.white
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView?.addSubview(searchController.searchBar)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : results.count
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        savedIndexPath = indexPath
        let selectedCell : Player = results[indexPath.row]
        playerID = selectedCell.pid
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentsDirectoryURL.appendingPathComponent("\(selectedCell.picFilePath)")
        print(fileURL)
        print("Selected person: \(selectedCell.firstName) & ID: \(playerID)")
        print(selectedCell.picFilePath)
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! CustomPlayerTableViewCell
        let object = searchController.isActive ? searchResults[indexPath.item] : results[indexPath.item]
        
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        cell.name.text = "\(object.firstName) \(object.lastName)"
        cell.dob.text = object.dob
        cell.stats.text = "G: \(object.goals), A: \(object.assists), Apps: \(object.appearances)"
        cell.squadNumber.text = "#\(object.squadNo)"
        
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(object.picFilePath)")
            let image    = UIImage(contentsOfFile: imageURL.path)
            cell.profilePic.image = image
        }
        cell.circlePicture()
        tableView.deselectRow(at: indexPath, animated: false)
        
        return cell
    }
    
    func filterResultsWithSearchString(searchString: String) {
        let predicateFN = NSPredicate(format: "firstName BEGINSWITH [c]%@", searchString)
        let predicateLN = NSPredicate(format: "lastName BEGINSWITH [c]%@", searchString)
        
        let predicateCompound = NSCompoundPredicate.init(type: .or, subpredicates: [predicateFN, predicateLN])
        
        let realm = try! Realm()
        searchResults = realm.objects(Player.self).filter(predicateCompound).sorted(byKeyPath: "lastName", ascending: true)
        
    }
    
    override func tableView(_ tableView: UITableView,
                            shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
       return false
    }


    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepared is called!")
            let nextScene = segue.destination as? EditPlayerViewController
            nextScene?.selectedPlayer = playerID
            print("Right player ID is sent! \(nextScene?.selectedPlayer as Any)")
    }

}







// MARK: - UISearchResultsUpdating
extension ViewPlayersController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text!
        filterResultsWithSearchString(searchString: searchString)
        self.tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension ViewPlayersController:  UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
}

