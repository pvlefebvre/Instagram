//
//  IndividualPostViewController.swift
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


class IndividualPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var postURL: NSURL?
    var profilePictureString: String?
    

    @IBOutlet weak var tableView: UITableView!
    
    var posts = Array<PostItem>()
    let max = 10
    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()
    var new_element:PostItem?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = postURL?.absoluteString as String?

        
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            //self.newArray.removeAll()
            let totalSnapshot = (snap.value as? NSDictionary)!
            if let posts = totalSnapshot["posts"] as? NSDictionary {
                for (key, value) in posts {
                    let targetPost = value as? NSDictionary
                    for (_, value2) in targetPost! {
//                        let targetChild = key2 as? NSDictionary
                        if value2 as? String == urlString {
                            
                            
                            self.new_element = PostItem(postID: "\(key)", caption: targetPost?.valueForKey("caption")! as! String, location: targetPost?.valueForKey("location")! as! String, likes: targetPost?.valueForKey("likes")! as! NSNumber,pictureID: targetPost?.valueForKey("imageString")! as! String, userID: targetPost?.valueForKey("userID")! as! String, username: targetPost?.valueForKey("username")! as! String, comments: [])
                            
                            
                            
                            self.posts.append(self.new_element!)

                        }
                    }
                                    }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }

    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! PostHeaderSingleCell
        
//        let urlString = (postURL?.absoluteString)! as String!
        headerCell.headerImage.layer.cornerRadius = headerCell.headerImage.frame.size.width/2
        headerCell.headerImage.clipsToBounds = true

        headerCell.headerImage.kf_setImageWithURL(NSURL(string: profilePictureString!)!, placeholderImage: nil)
        headerCell.headerLabel.text = new_element!.username as String!
        return headerCell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250.0
        } else if indexPath.row == 1{
            return 44.0
        } else {
            return 100.0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let item = posts[indexPath.section]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! PostImageSingleCell
            
            let urlString = (postURL?.absoluteString)! as String
            cell.photoImageView.kf_setImageWithURL(NSURL(string: urlString)!, placeholderImage: nil)
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("SubBarCell", forIndexPath: indexPath) as! PostSubBarSingleCell
            cell.postID = posts[indexPath.section].postID as String
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! PostCommentSingleCell
            cell.textView.text = posts[indexPath.section].caption as String
            
            return cell
        }
        
    }
    


}
