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
import UIView_draggable
import FaceAware


// MARK: - UISearchResultsUpdating
extension ViewPlayersController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchBar: UISearchController) {
        let searchString = searchBar.searchBar.text!
        filterResultsWithSearchString(searchString: searchString)
        
        let searchResultsController = searchBar.searchResultsController as! UITableViewController
        searchResultsController.tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension ViewPlayersController:  UISearchBarDelegate {
    
}

class ViewPlayersController: UITableViewController {
    
    
    

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchController!
    @IBAction func backNav(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    
    let realm = try! Realm()
    var results = try! Realm().objects(Player.self).sorted(byKeyPath: "lastName",  ascending: true)
    var searchResults = try! Realm().objects(Player.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.reloadData()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! CustomPlayerTableViewCell
        
        let object = searchBar.isActive ? searchResults[indexPath.row] : results[indexPath.row]
        
        cell.name?.text = "\(object.firstName) \(object.lastName)"
        cell.dob?.text = object.dob
        print (paths)
        print (object.picFilePath)
        
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(object.picFilePath)")
            let image    = UIImage(contentsOfFile: imageURL.path)
            // Do whatever you want with the image
            
            cell.profilePic?.image = image
            cell.profilePic.focusOnFaces = true
            
        }
        cell.circlePicture()
        
        return cell
    }
    
    func filterResultsWithSearchString(searchString: String) {
        let predicate = NSPredicate(format: "name BEGINSWITH [c]%@", searchString)
        let scopeIndex = searchBar.searchBar.selectedScopeButtonIndex
        let realm = try! Realm()
        
        switch scopeIndex {
        case 0:
            searchResults = realm.objects(Player.self).filter(predicate).sorted(byKeyPath: "lastNames", ascending: true)
        case 1:
            searchResults = realm.objects(Player.self).filter(predicate).sorted(byKeyPath: "dob", ascending: true)
        default:
            searchResults = realm.objects(Player.self).filter(predicate)
        }
    }

    @IBAction func scopeChanged(_ sender: Any) {
        let scopeBar = sender as! UISegmentedControl
        let realm = try! Realm()
        
        switch scopeBar.selectedSegmentIndex {
        case 0:
            results = realm.objects(Player.self).sorted(byKeyPath: "name", ascending: true)
        case 1:
            results = realm.objects(Player.self).sorted(byKeyPath: "created", ascending: true)
        default:
            results = realm.objects(Player.self).sorted(byKeyPath: "name", ascending: true)
        }
        tableView.reloadData()
    }
    

}
