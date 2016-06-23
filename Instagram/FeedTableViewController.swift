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

struct PostItem {
    var postID: NSString
    var caption: NSString
    var location: NSString
    var likes: NSNumber
    var pictureID: NSString
    var userID: NSString
    var comments: Array<NSString>

}

class FeedTableViewController: UITableViewController {

    var posts = Array<PostItem>()
    let max = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        ref.child("posts").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//            // Get user value
//            let username = snapshot.value!["username"] as! String
//            let user = User.init(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        var new_element:PostItem
        new_element = PostItem(postID: "123",caption: "132",location: "321",likes: 2,pictureID: "1232",userID: "1323", comments: ["12323","1232323","!@#@!#"])
        posts.append(new_element)
        
        

    }
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! PostHeaderCell
        headerCell.profileName.setTitle(FIRAuth.auth()?.currentUser?.email!, forState: UIControlState.Normal)
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
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! PostImageCell
            cell.postImage.image = UIImage.init(named: "example1")
            //cell.postImage.contentMode = UIViewContentMode.ScaleAspectFill
            return cell
        } else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCellWithIdentifier("SubBarCell", forIndexPath: indexPath) as! PostSubBarCell
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
