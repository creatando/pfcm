//
//  MainMenuViewController.swift
//  PFCM
//
//  Created by Thomas Anderson on 03/03/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import GuillotineMenu
import Hue

var dismissButton: UIButton?
var titleLabel: UILabel?

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        menuItems()
        // Do any additional setup after loading the view.
    }
    
    func menuItems() {
        dismissButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "closebtn"), for: .normal)
            button.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
            return button
        }()
        
        titleLabel = {
            let label = UILabel()
            label.numberOfLines = 1;
            label.text = "Main Menu"
            label.font = UIFont.boldSystemFont(ofSize: 17)
            label.textColor = UIColor.white
            label.sizeToFit()
            return label
        }()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu: viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Menu: viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Menu: viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Menu: viewDidDisappear")
    }
    
    func dismissButtonTapped(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func homeTapped(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "Home")
        
        present(menuViewController, animated: true, completion: nil)
        
    }
    
    @IBAction func playerTapped(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "PlayerCentre")
        let navController = UINavigationController.init(rootViewController: menuViewController)
        
        navController.navigationBar.barTintColor = UIColor(hex: "#31A343")
        
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func tacticTapped(_ sender: UIButton) {
        let menuViewController = storyboard!.instantiateViewController(withIdentifier: "TacticCentre")
        let navController = UINavigationController.init(rootViewController: menuViewController)
        
        navController.navigationBar.barTintColor = UIColor(hex: "#31A343")
        
        present(navController, animated: true, completion: nil)
    }
    
    @IBAction func closeMenu(_ sender: UIButton) {
        presentingViewController!.dismiss(animated: true, completion: nil)
    }


}

extension MainMenuViewController: GuillotineAnimationDelegate {
    
    func animatorDidFinishPresentation(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(_ animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(_ animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(_ animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}
