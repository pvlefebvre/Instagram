//
//  FeedTableViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/18/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var table_data = Array<TableData>()
    
    struct TableData {
        var section:String = ""
        var data = Array<String>()
        init(){}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var new_element:TableData
        new_element = TableData()
        new_element.section = "Section 1"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        
        new_element = TableData()
        new_element.section = "Section 2"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        
        new_element = TableData()
        new_element.section = "Section 3"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        
        new_element = TableData()
        new_element.section = "Section 4"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        
        new_element = TableData()
        new_element.section = "Section 5"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        
        new_element = TableData()
        new_element.section = "Section 6"
        new_element.data.append("Element 1")
        new_element.data.append("Element 2")
        new_element.data.append("Element 3")
        table_data.append(new_element)
        

    }
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! PostHeaderCell
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return table_data.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table_data[section].data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! PostImageCell
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
