//
//  ViewPlayerController.swift
//  PFCM
//
//  Created by Thomas Anderson on 11/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import RealmSwift

class ViewPlayerController: UIViewController {

    var players: Results<Player>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //let realm = try! Realm()
        //players = realm.objects(Player)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
