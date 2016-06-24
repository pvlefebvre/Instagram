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
    
    let user = FIRAuth.auth()?.currentUser?.uid
    var currentUsername: String?
    
    var selectedUsername: String?
    
    var urlString: String?
    
    var otherProfile: Bool?
    
//    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.users.removeAll()
            let snapshotVal = snapshot.value! as! [String : AnyObject]
            for (keyt, valuest) in snapshotVal {
                if keyt != FIRAuth.auth()?.currentUser?.uid {
                    let namet = valuest["username"] as! String
                    print(namet)
                    let pict = valuest["profilePicture"] as! String
                    let item = UserItem(username: namet, profilePicture: pict, userID: keyt)
                    self.users.append(item)
                }
            }

        }) { (error) in
            print(error.localizedDescription)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
        
        ref.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            let totalSnap = (snap.value as? NSDictionary)!
            if let users = totalSnap["users"] as? NSDictionary {
                
                self.currentUsername = users.valueForKey("\(self.user!)")!.valueForKey("username")! as? String
//                self.title = "\(self.currentUsername!)"
                
                self.urlString = users.valueForKey("\(self.user!)")!.valueForKey("profilePicture")! as? String
            }
        }
        
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
            
            cell.searchCellLabel.text = filteredUsers[indexPath.row].username as String
            let profPicString = filteredUsers[indexPath.row].profilePicture
            cell.searchCellImage.kf_setImageWithURL(NSURL(string: "\(profPicString)")!, placeholderImage: nil)
            cell.searchCellImage.layer.cornerRadius = cell.searchCellImage.frame.size.width/2
            cell.searchCellImage.clipsToBounds = true


//            cell.usernameButton.setTitle(filteredUsers[indexPath.row].username as String, forState: UIControlState.Normal)
            cell.userID = filteredUsers[indexPath.row].userID as String
            
        } else {
            
            cell.searchCellLabel.text = users[indexPath.row].username as String
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
        
//        if 
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        view.endEditing(true)
        
        if isFiltered == true {
        selectedUsername = filteredUsers[indexPath.row].username as String
        } else {
            selectedUsername = users[indexPath.row].username as String
        }
        
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("profileSB") as! ProfileViewController
        viewController.otherUser = selectedUsername!
        viewController.otherProfile = true
//        pushViewController(viewController, animated: true , completion: nil)
        showViewController(viewController, sender: self)


//        performSegueWithIdentifier("ToSearchedProfile", sender: self)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ToSearchedProfile" {
//            let dvc = segue.destinationViewController as? ProfileViewController
//            otherProfile = true
//            dvc!.otherProfile = otherProfile
//            dvc!.otherUser = selectedUsername
//            
//        }
//    }
//    func search
}
