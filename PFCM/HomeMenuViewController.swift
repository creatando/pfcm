//
//  HomeMenuViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 03/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Welcome")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Change the ratio or enter a fixed value, whatever you need
    var cellHeight: CGFloat {
        return 200
    }
    
    // Just an alias to make the code easier to read
    var imageVisibleHeight: CGFloat {
        return cellHeight
    }
    
    // Change this value to whatever you like (it sets how "fast" the image moves when you scroll)
    let parallaxOffsetSpeed: CGFloat = 35
    
    // This just makes sure that whatever the design is, there's enough image to be displayed.
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * tableView.frame.height) - cellHeight) / 2
        return imageVisibleHeight + maxOffset
    }
    
    // Used when the table dequeues a cell, or when it scrolls
    func parallaxOffsetFor(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return ((newOffsetY - cell.frame.origin.y) / parallaxImageHeight) * parallaxOffsetSpeed
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        
        for cell in tableView.visibleCells as! [ParallaxTableViewCell] {
            cell.parallaxTopConstraint.constant = parallaxOffsetFor(newOffsetY: offsetY, cell: cell)
        }
    }


}
