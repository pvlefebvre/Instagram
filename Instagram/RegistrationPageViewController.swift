//
//  RegistrationPageViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/21/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class RegistrationPageViewController: UIViewController {

    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var usernameTextField: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    @IBAction func registerButton(sender: AnyObject) {
//        let userEmail = emailTextField.text
//        let userPassword = passwordTextField.text
//        let userName = nameTextField.text
//        let confirmPassword = confirmPasswordTextField.text
//        let userUsername = usernameTextField.text
//        if(userEmail?.isEmpty || userPassword?.isEmpty || userName?.isEmpty || confirmPassword || (userUsername?.isEmpty){
//            
////        displayAlertMessage("Fill em' all out LADY!")
////        } else {
////        nil
////        }
////        
////        if userPassword != confirmPassword {
////        displayAlertMessage("Passwords = No Bueno, Again!")
////    }
////        func displayAlertMessage(userMessage:String)
////        {
////            
////            var alert = UIAlertController(title: "Stahp", message: "Why you no do!", preferredStyle: UIAlertControllerStyle.Alert)
////        
////            alert.addTextFieldWithConfigurationHandler(nil)
////            alert.addAction(UIAlertAction(title: "Welp", style: UIAlertActionStyle.Cancel, handler: nil))
////            alert.addAction(UIAlertAction(title: "Ya Done", style: UIAlertActionStyle.Default, handler: nil))
////        
////            self.presentViewController(alertController, animated: true, completion:nil)
////        
////        }
////        
////    }
////
////    
////
////
}