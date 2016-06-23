//
//  SearchViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/22/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

struct UserItem {
    var username: NSString
    var profilePicture: NSString
    var userID: NSString
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isFiltered = false

    var users = Array<UserItem>()
    var filteredUsers = Array<UserItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let stuff3 = snapshot.value! as! [String : AnyObject]
            for (keyt, valuest) in stuff3 {
                let namet = valuest["username"] as! String
                let item = UserItem(username: namet, profilePicture: "", userID: keyt)
                self.users.append(item)
            }

        }) { (error) in
            print(error.localizedDescription)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! FollowTableViewCell
        if isFiltered {
            cell.usernameButton.setTitle(filteredUsers[indexPath.row].username as String, forState: UIControlState.Normal)
            cell.userID = filteredUsers[indexPath.row].userID as String
        } else {
            cell.usernameButton.setTitle(users[indexPath.row].username as String, forState: UIControlState.Normal)
            cell.userID = users[indexPath.row].userID as String
        }
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = users.filter({ (text) -> Bool in
            let tmp: NSString = text.username
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if filteredUsers.count == 0 {
            isFiltered = false
        } else {
            isFiltered = true
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
