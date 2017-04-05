//
//  SignUpViewController.swift
//  Premier Football Club Management
//
//  Created by Thomas Anderson on 04/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    //Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var clubnameTextField: UITextField!
    @IBOutlet weak var emailConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    

    
    //Sign Up Action for email
    @IBAction func createAccountAction(_ sender: AnyObject) {
            if emailTextField.text == "" || passwordTextField.text == "" {
                let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
                
            } else if emailTextField.text != emailConfirmTextField.text || passwordTextField.text != passwordConfirmTextField.text {
                let alertController = UIAlertController(title: "Error", message: "Email or password doesn't match, try again", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            } else {
                FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    
                    if error == nil {
                        
                        let newClub = ["clubName": self.clubnameTextField.text, "clubContact": self.contactTextField.text]
                        print("You have successfully signed up")
                        var ref: FIRDatabaseReference!
                        ref = FIRDatabase.database().reference()
                        ref.child(user!.uid).setValue(newClub)
                        print("database set")
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                        self.present(vc!, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
    
}

