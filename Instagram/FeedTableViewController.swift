//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/18/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Kingfisher

struct PostItem {
    var postID: NSString
    var caption: NSString
    var location: NSString
    var likes: NSNumber
    var pictureID: NSString
    var userID: NSString
    var username: NSString
    var comments: Array<Comment>
    
}

class FeedTableViewController: UITableViewController {
    
    var posts = Array<PostItem>()
    let max = 10
    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()
    
    var accountsFollowedArray = [String]()
    var postURLArray = [NSURL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // snapshot of all database - goal here is to pull out the uid of everyone you follow and place that within an array
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            
            let receivedUsers = (snap.value as? NSDictionary)!
            
            // pulling out all of the users from the database
            if let users = receivedUsers["users"] as? NSDictionary {
                
                for (key, value) in users {
                    
                    // if the key == your uid
                    if key as! String == (FIRAuth.auth()?.currentUser?.uid)! {
                        if let following = value["following"] as? NSDictionary {
                            
                            for (_, value2) in following {
                                let followedAccount = value2 as? NSDictionary
                                for (_,value3) in followedAccount! {
                                    let uIDString = value3 as! String
                                    self.accountsFollowedArray.append(uIDString)
                                }
                            }
                        }
                    }
                }
            }
            self.accountsFollowedArray.append((FIRAuth.auth()?.currentUser?.uid)! as String)
            print("accountsFollowedArray: \(self.accountsFollowedArray)")
        }
        
        // Part two is to search through the posts and input all the ones that are from someone you follow into array for feed.
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in

            let databaseSnapshot = (snap.value as? NSDictionary)!
            
            if let postsData = databaseSnapshot["posts"] as? NSDictionary {
                
                for (key, value) in postsData {
                    let valueDict = value as! NSDictionary
                    if self.accountsFollowedArray.contains(valueDict.valueForKey("userID") as! String) {
                        
                        /* method for just getting the URLs of necessary posts
                        let postURLString = valueDict.valueForKey("imageString")! as! String
                        let postURL = NSURL(string: postURLString)
                        self.postURLArray.append(postURL!)
                        */
                        
                        var postComments = Array<Comment>()
                        let finalPost = value as? NSDictionary
                        var new_element:PostItem
                        if let pComments = finalPost!["comments"] as? [String : AnyObject] {
                            for (_,value) in pComments{
                                let item1 = value["userID"] as! String
                                let item2 = value["username"] as! String
                                let item3 = value["message"] as! String
                                let com = Comment(userID: item1, username: item2, message: item3)
                                postComments.append(com)
                            }
                        }
                        new_element = PostItem(postID: "\(key)",caption: "\((finalPost!["caption"])!)",location: "\((finalPost!["location"])!)",likes: finalPost!["likes"] as! NSNumber,pictureID: "\((finalPost!["imageString"])!)",userID: "\((finalPost!["userID"])!)", username: "\((finalPost!["username"])!)", comments: postComments)
                        
                        self.posts.append(new_element)
                        
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })

            }
            
        }
        /*
         // Paul's old process.
         // Need to update this process to only show posts from people you follow
         
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            
            let receivedPosts = (snap.value as? NSDictionary)!
            if let post = receivedPosts["posts"] as? NSDictionary {
                
                //check if post was made by someone you follow??
                print("\(post)")
                for (key, value) in post {
                    print("key: \(key)")
                    print("value: \(value)")
                    // if finalPost
                    let idToTest = value["userID"] as! String
                    if self.accountsFollowedArray.contains(idToTest) {
         
         
                        var postComments = Array<Comment>()
                        let finalPost = value as? NSDictionary
                        var new_element:PostItem
                        if let pComments = finalPost!["comments"] as? [String : AnyObject] {
                            for (_,value) in pComments{
                                let item1 = value["userID"] as! String
                                let item2 = value["username"] as! String
                                let item3 = value["message"] as! String
                                let com = Comment(userID: item1, username: item2, message: item3)
                                postComments.append(com)
                            }
                        }
                        new_element = PostItem(postID: "\(key)",caption: "\((finalPost!["caption"])!)",location: "\((finalPost!["location"])!)",likes: finalPost!["likes"] as! NSNumber,pictureID: "\((finalPost!["imageString"])!)",userID: "\((finalPost!["userID"])!)", username: "\((finalPost!["username"])!)", comments: postComments)
                        
                        self.posts.append(new_element)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        */
        
        
        
        //                    if self.accountsFollowedArray.contains(idToTest) {
        //
        //                        var postComments = Array<Comment>()
        //                        let finalPost = value as? NSDictionary
        //                        var new_element:PostItem
        //                        if let pComments = finalPost!["comments"] as? [String : AnyObject] {
        //                            for (_,value) in pComments{
        //                                let item1 = value["userID"] as! String
        //                                let item2 = value["username"] as! String
        //                                let item3 = value["message"] as! String
        //                                let com = Comment(userID: item1, username: item2, message: item3)
        //                                postComments.append(com)
        //                            }
        //                        }
        //                        new_element = PostItem(postID: "\(key)",caption: "\((finalPost!["caption"])!)",location: "\((finalPost!["location"])!)",likes: finalPost!["likes"] as! NSNumber,pictureID: "\((finalPost!["imageString"])!)",userID: "\((finalPost!["userID"])!)", username: "\((finalPost!["username"])!)", comments: postComments)
        //
        //                        self.posts.append(new_element)
        //                        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! PostHeaderCell
        headerCell.profileName.setTitle(posts[section].username as String, forState: UIControlState.Normal)
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250.0
        } else if indexPath.row == 1{
            return 44.0
        } else {
            return 100.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = posts[indexPath.section]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! PostImageCell
            cell.postImage.kf_setImageWithURL(NSURL(string: "\(item.pictureID)")!, placeholderImage: nil)
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("SubBarCell", forIndexPath: indexPath) as! PostSubBarCell
            cell.postID = posts[indexPath.section].postID as String
            cell.likeLabel.text = "\(posts[indexPath.section].likes)"
            cell.commentButton.restorationIdentifier = "\(indexPath.section)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! PostCommentCell
            let comments = NSMutableString()
            comments.appendString("\(posts[indexPath.section].caption)\n")
            for com in posts[indexPath.section].comments {
                comments.appendString("\(com.username):\n\(com.message)\n")
            }
            cell.commentsTextView.text = comments as String
            return cell
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "commentSegue" {
            let dvc = segue.destinationViewController as! CommentViewController
            let item = "\((sender!.restorationIdentifier!)!)" as NSString
            let item2 = item.integerValue
            dvc.postID = posts[item2].postID
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
