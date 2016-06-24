//
//  PostSubBarSingleCell.swift
//  Instagram
//
//  Created by Lance Russ on 6/24/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class PostSubBarSingleCell: UITableViewCell {

    var postID: String?
    
    let postRef = FIRDatabase.database().reference().child("posts")
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onLikeButtonPressed(sender: AnyObject) {
//        postRef.child("\(self.postID!)").runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
//            if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
//                var stars : Dictionary<String, Bool>
//                stars = post["likers"] as? [String : Bool] ?? [:]
//                var starCount = post["likes"] as? Int ?? 0
//                if let _ = stars[uid] {
//                    // Unstar the post and remove self from stars
//                    starCount -= 1
//                    stars.removeValueForKey(uid)
//                } else {
//                    // Star the post and add self to stars
//                    starCount += 1
//                    stars[uid] = true
//                }
//                post["likes"] = starCount
//                post["likers"] = stars
//                
//                // Set value and report transaction success
//                currentData.value = post
//                
//                return FIRTransactionResult.successWithValue(currentData)
//            }
//            return FIRTransactionResult.successWithValue(currentData)
//        }) { (error, committed, snapshot) in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }

    }

    @IBOutlet weak var onCommentButtonPressed: UIButton!
}
