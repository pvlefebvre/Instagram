//
//  LoginViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/22/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginDidTouch(sender: AnyObject) {
        if emailField.text != nil && passwordField.text != nil {
            FIRAuth.auth()?.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { (user: FIRUser?, error: NSError?) in
                if error == nil {
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                } else {
                    print("ERROR!!!!: \(error)")
                }
            })
        }
    }

    @IBAction func unwindDidTouch(sender: UIStoryboardSegue) {}
}
