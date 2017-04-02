//
//  LoginViewController.swift
//  Premier Football Club Management
//
//  Created by Thomas Anderson on 04/02/2017.
//  Copyright © 2017 Thomas Anderson. All rights reserved.
//

import UIKit
import Realm


/* Login/Register Credentials */
public var serverURL: String?
public var serverPort = 9080
public var username: String?
public var password: String?
public var confirmPassword: String?
public var rememberLogin: Bool = true
public var loginSuccessfulHandler: ((RLMSyncUser) -> Void)?

/**
 Manages whether the view controller is currently logging in an existing user,
 or registering a new user for the first time
 */
public var isRegistering: Bool?

class LoginViewController: UIViewController {


//Outlets
@IBOutlet weak var emailTextField: UITextField!
@IBOutlet weak var passwordTextField: UITextField!


    //Login Action
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            var authScheme = "http"
            var scheme: String?
            var formattedURL = serverURL
            if let schemeRange = formattedURL?.range(of: "://") {
                scheme = formattedURL?.substring(to: schemeRange.lowerBound)
                if scheme == "realms" || scheme == "https" {
                    serverPort = 9443
                    authScheme = "https"
                }
                formattedURL = formattedURL?.substring(from: schemeRange.upperBound)
            }
            if let portRange = formattedURL?.range(of: ":") {
                if let portString = formattedURL?.substring(from: portRange.upperBound) {
                    serverPort = Int(portString) ?? serverPort
                }
                formattedURL = formattedURL?.substring(to: portRange.lowerBound)
            }
            
            let credentials = RLMSyncCredentials(username: username!, password: password!, register: isRegistering!)
            RLMSyncUser.__logIn(with: credentials, authServerURL: URL(string: "\(authScheme)://\(formattedURL!):\(serverPort)")!, timeout: 30, onCompletion: { (user, error) in
                DispatchQueue.main.async {
                    
                    if let error = error {
                        let alertController = UIAlertController(title: "Unable to Sign In", message: error.localizedDescription, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                    
                    loginSuccessfulHandler?(user!)
                }
            })
        }
    }
}
