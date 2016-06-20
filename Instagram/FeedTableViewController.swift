//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/18/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    var postViews: [PostView] = []
    var padding: CGFloat = 5.0
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = tableView.frame.width
        height = 420.0
        print(height)
        let newView1 = PostView(frame: CGRectMake(padding, padding, (width - padding * 2), (height - 2 * padding)))
        let newView2 = PostView(frame: CGRectMake(padding, padding, (width - padding * 2), (height - 2 * padding)))
        let newView3 = PostView(frame: CGRectMake(padding, padding, (width - padding * 2), (height - 2 * padding)))
        postViews.append(newView1)
        postViews.append(newView2)
        postViews.append(newView3)
        //xibPost = PostView.init(frame: CGRectMake(0, 0, 100, 100))
        //xibPost.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViews.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        //cell.textLabel?.text = arrayy[indexPath.row]
        //xibPost.translatesAutoresizingMaskIntoConstraints = false
        //cell.contentView.addSubview(xibPost)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel!.enabled = false
        //cell.layoutMargins = UIEdgeInsetsZero
        cell.contentView.addSubview(postViews[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 430.0
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
