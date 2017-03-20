//
//  TacticsCentreViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 03/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import GuillotineMenu

class TacticsCentreViewController: UITableViewController {
    
    fileprivate lazy var presentationAnimator = GuillotineTransitionAnimation()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func menuButton(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "MainMenuViewController")
        menuViewController.modalPresentationStyle = .custom
        menuViewController.transitioningDelegate = self
        
        presentationAnimator.animationDelegate = menuViewController as? GuillotineAnimationDelegate
        presentationAnimator.supportView = navigationController!.navigationBar
        presentationAnimator.presentButton = sender
        present(menuViewController, animated: true, completion: nil)
        

    }
   

}


extension TacticsCentreViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .presentation
        return presentationAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .dismissal
        return presentationAnimator
    }
}
