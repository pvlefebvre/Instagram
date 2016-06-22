//
//  RegistrationPageViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/21/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

class RegistrationPageViewController: UIViewController {


    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var realNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func registerDidTouch(sender: AnyObject) {
        if usernameField.text != nil &&
            emailField.text != nil &&
            realNameField.text != nil &&
            passwordField.text != nil &&
            confirmPasswordField.text != nil{
            
            if passwordField.text == confirmPasswordField.text {
                FIRAuth.auth()?.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error: NSError?) in
                    if error == nil {
                        self.performSegueWithIdentifier("createUserSegue", sender: self)
                    } else {
                        print("ERROR!!!!: \(error)")
                    }
                    
                    
                })
            }
        }
    }

}