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

class ViewPlayersController: UITableViewController {
    
    
 
    @IBAction func backNav(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    
    let realm = try! Realm()
    let results = try! Realm().objects(Player.self).sorted(byKeyPath: "lastName")
    
    
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
        
        let object = results[indexPath.row]
        
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
    

}
