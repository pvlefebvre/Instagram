//
//  CommentViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/24/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var comments = Array<Comment>()
    let user = FIRAuth.auth()?.currentUser
    let ref = FIRDatabase.database().reference()
    var postID: NSString?
    var commentUsername: NSString?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        ref.child("posts").child("\(postID!)/comments").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let dic: [String: AnyObject] = snapshot.value! as? [String : AnyObject]{
                for (_,value) in dic{
                    let item1 = value["userID"] as! String
                    let item2 = value["username"] as! String
                    let item3 = value["message"] as! String
                    let com = Comment(userID: item1, username: item2, message: item3)
                    self.comments.append(com)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("users").child((user?.uid)!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.commentUsername = snapshot.value!["username"] as! String
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = keyboardFrame.size.height + 5
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.bottomConstraint.constant = 54
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentID", forIndexPath: indexPath)
        cell.textLabel?.text = comments[indexPath.row].username as String
        cell.detailTextLabel?.text = comments[indexPath.row].message as String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let newComment = Comment(userID: (user?.uid)!,
                                 username: self.commentUsername!,
                                 message: textField.text!)
        
        comments.append(newComment)
        
//        ref.child("comments").child(commentObjectID!).setValue(["postID": newComment.postID, "userID" : newComment.userID, "username" : newComment.username, "message" : newComment.message])
        let database = ref.child("posts/\(postID!)/comments")
        database.childByAutoId().setValue(["userID" : newComment.userID, "username" : newComment.username, "message" : newComment.message])
        
        textField.resignFirstResponder()
        tableView.reloadData()
        return true
    }


}
