//
//  TacticalScreenViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 19/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import UIView_draggable

class TacticalCentreViewController: UIViewController {

    @IBOutlet weak var pB1: UIView!
    @IBOutlet weak var pB2: UIView!
    @IBOutlet weak var pB3: UIView!
    @IBOutlet weak var pB4: UIView!
    @IBOutlet weak var pB5: UIView!
    @IBOutlet weak var pB6: UIView!
    @IBOutlet weak var pB7: UIView!
    @IBOutlet weak var pB8: UIView!
    @IBOutlet weak var pB9: UIView!
    @IBOutlet weak var pB10: UIView!
    @IBOutlet weak var pB11: UIView!
    @IBOutlet weak var backPanel: UIImageView!
    @IBAction func backNav(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPlayerButton(_ sender: Any) {
    }
    
    
    var cage = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableDrag()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableDrag() {
        cage = self.backPanel.frame
        
        pB1.enableDragging()
        pB1.cagingArea = cage
        
        pB2.enableDragging()
        pB2.cagingArea = cage
        
        pB3.enableDragging()
        pB3.cagingArea = cage
        
        pB4.enableDragging()
        pB4.cagingArea = cage
        
        pB5.enableDragging()
        pB5.cagingArea = cage
        
        pB6.enableDragging()
        pB6.cagingArea = cage
        
        pB7.enableDragging()
        pB7.cagingArea = cage
        
        pB8.enableDragging()
        pB8.cagingArea = cage
        
        pB9.enableDragging()
        pB9.cagingArea = cage
        
        pB10.enableDragging()
        pB10.cagingArea = cage
        
        pB11.enableDragging()
        pB11.cagingArea = cage
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
