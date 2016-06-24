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
    var comments: Array<NSString>

}

class FeedTableViewController: UITableViewController {

    var posts = Array<PostItem>()
    let max = 10
    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //////////////////////////////////////////
        
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            //self.newArray.removeAll()
            let receivedPosts = (snap.value as? NSDictionary)!
            if let post = receivedPosts["posts"] as? NSDictionary {
                    for (key, value) in post {
                        let finalPost = value as? NSDictionary
                        var new_element:PostItem
                        new_element = PostItem(postID: "\(key)",caption: "\((finalPost!["caption"])!)",location: "\((finalPost!["location"])!)",likes: finalPost!["likes"] as! NSNumber,pictureID: "\((finalPost!["imageString"])!)",userID: "\((finalPost!["userID"])!)", username: "\((finalPost!["username"])!)", comments: ["12323","1232323","!@#@!#"])
                        
                        
                      self.posts.append(new_element)
                    }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
            }
        }
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! PostCommentCell
            return cell
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
