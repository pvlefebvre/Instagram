//
//  RegistrationPageViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/21/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct instaUser {
    var username: NSString
    var email: NSString
    var profileDescription: NSString
    var profilePicture: NSString
    var realName: NSString
}

class RegistrationPageViewController: UIViewController, UITextFieldDelegate {

    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()

    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var realNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                        
                        let database = self.rootRefDB.child("users")
                        
                        let cUser = instaUser(username: self.usernameField.text!,
                            email: user!.email!,
                            profileDescription: "",
                            profilePicture: "",
                            realName: self.realNameField.text!)

                        database.child(user!.uid).setValue(["username": cUser.username,
                            "email": cUser.email, "profileDescription": cUser.profileDescription,
                            "profilePicture": cUser.profilePicture, "realName": cUser.realName])
                        
                        self.performSegueWithIdentifier("createUserSegue", sender: self)
                    } else {
                        print("ERROR!!!!: \(error)")
                    }
                  
                })
            }
        }
    }

}