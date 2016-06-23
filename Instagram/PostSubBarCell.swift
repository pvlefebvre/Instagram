//
//  PostSubBarCell.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/20/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

class PostSubBarCell: UITableViewCell {
    
    var postID: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("HELLO")
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("World")
        // Configure the view for the selected state
    }

    @IBAction func likeDidTouch(sender: UIButton) {
        print("\(self.postID!)")
        print("posts/\((self.postID)!)")
        let postRef = FIRDatabase.database().reference().child("posts/\((self.postID)!)")
        postRef.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
                var stars : Dictionary<String, Bool>
                stars = post["likers"] as? [String : Bool] ?? [:]
                var starCount = post["likes"] as? Int ?? 0
                if let _ = stars[uid] {
                    // Unstar the post and remove self from stars
                    starCount -= 1
                    stars.removeValueForKey(uid)
                    sender.backgroundColor = UIColor.grayColor()
                } else {
                    // Star the post and add self to stars
                    starCount += 1
                    stars[uid] = true
                    sender.backgroundColor = UIColor.yellowColor()
                }
                post["likes"] = starCount
                post["likers"] = stars
                
                // Set value and report transaction success
                currentData.value = post
                
                return FIRTransactionResult.successWithValue(currentData)
            }
            return FIRTransactionResult.successWithValue(currentData)
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func commentDidTouch(sender: UIButton) {
        print("dfsdffd")
    }

}
