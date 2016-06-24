//
//  CommentViewController.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/23/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    let user = FIRAuth.auth()?.currentUser
    let ref = FIRDatabase.database().reference()
    var postID: NSString?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
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
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {

        let newComment = Comment(postID: self.postID!,
                                 userID: (user?.uid)!,
                                 username: "faddfsd",
                                 message: textField.text!)
        
        newComment.objectId = "\(unsafeAddressOf(newComment))"
        let commentObjectID = newComment.objectId
        
        ref.child("comments").child(commentObjectID!).setValue(["postID": newComment.postID, "userID" : newComment.userID, "username" : newComment.username, "message" : newComment.message])
        
        textField.resignFirstResponder()
        return true
    }
    


}
