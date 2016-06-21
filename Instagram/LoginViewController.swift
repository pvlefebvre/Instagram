//
//  LoginViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/21/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("toLoginView", sender: self)
    }


}
