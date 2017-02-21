//
//  TacticalScreenViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 19/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import UIView_draggable

extension UIView {
    func setCorners() {
        self.layer.cornerRadius = 9.5
        self.layer.borderColor = UIColor.white
            .cgColor
        self.layer.borderWidth = 0.7
        self.clipsToBounds = true
    }
    func addDropShadowToView(){
        self.layer.masksToBounds =  false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width:2.0, height: 1.5)
        self.layer.shadowOpacity = 0.2
    }
}

class TacticalCentreViewController: UIViewController, UIPopoverPresentationControllerDelegate {

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


    @IBAction func addClick(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "popoverID")
        
        vc.modalPresentationStyle = .popover
        let popover = vc.popoverPresentationController!
        popover.delegate = self
        popover.permittedArrowDirections = .up
        popover.sourceView = sender
        popover.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.size.width, height: sender.frame.size.height)
        present(vc, animated: true, completion:nil)
    }
  
    var cage = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableDrag()
        setViewsCorners()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UIPopoverPresentationControllerDelegate method
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // return UIModalPresentationStyle.FullScreen
        return UIModalPresentationStyle.none
    }
    
    
    
    func setViewsCorners(){
        pB1.setCorners()
        pB2.setCorners()
        pB3.setCorners()
        pB4.setCorners()
        pB5.setCorners()
        pB6.setCorners()
        pB7.setCorners()
        pB8.setCorners()
        pB9.setCorners()
        pB10.setCorners()
        pB11.setCorners()
        
        pB1.addDropShadowToView()
        pB2.addDropShadowToView()
        pB3.addDropShadowToView()
        pB4.addDropShadowToView()
        pB5.addDropShadowToView()
        pB6.addDropShadowToView()
        pB7.addDropShadowToView()
        pB8.addDropShadowToView()
        pB9.addDropShadowToView()
        pB10.addDropShadowToView()
        pB11.addDropShadowToView()
    }
    
    func enableDrag() {
        cage = self.backPanel.frame
        
        //pB1.enableDragging()
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

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        
        
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool
    {
        return true
    }

}
