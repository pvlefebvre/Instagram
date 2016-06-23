//
//  FollowTableViewCell.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/22/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

class FollowTableViewCell: UITableViewCell {


    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    var userID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func followDidTap(sender: AnyObject) {
        if let user = FIRAuth.auth()?.currentUser {
            let ref = FIRDatabase.database().reference()
            let name = (usernameButton.titleLabel?.text)!
            ref.child("users/\(user.uid)/following").setValue(["\(self.userID!)" : name])
            
        } else {
            print("no")
        }
    }

}
