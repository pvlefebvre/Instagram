//
//  AddPhotoDetailsViewController.swift
//  Instagram
//
//  Created by Lance Russ on 6/20/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

//struct NewPost {
//    var userID: NSString
//    var caption: NSString
//    var location: NSString
//    var image: NSString
//    var likeCount: NSNumber = 0
//    optional var objectID: NSString
//}

class AddPhotoDetailsViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var locationTextView: UITextView!
    
    let rootRefDB = FIRDatabase.database().reference() //reference to the root database
    let rootRefStorage = FIRStorage.storage().reference()
    let user = FIRAuth.auth()?.currentUser?.uid
    var currentUsername: String?
    
    
    var postImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = postImage
        commentTextView.delegate = self
        locationTextView.delegate = self
        
        imageView.clipsToBounds = true
        
        
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            let totalSnap = (snap.value as? NSDictionary)!
            if let users = totalSnap["users"] as? NSDictionary {
                //                let valueDict = users
                self.currentUsername = users.valueForKey("\(self.user!)")!.valueForKey("username")! as? String
                
                //                        if value as! String == self.user! {
                //                            let username = valueDict.valueForKey("username")! as! String
                //                            self.currentUsername = username
                //                        }
            }
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func onPostButtonPressed(sender: UIButton) {
        
        let imageData = imageView.image?.lowQualityJPEGNSData
        
        let photosRef = rootRefStorage.child("\(user)_photos")
        let database = self.rootRefDB.child("posts") //2
        
        
        let photoRef = photosRef.child("\(NSUUID().UUIDString).jpg")
        
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        photoRef.putData(imageData!, metadata: metadata).observeStatus(.Success) { (snapshot) in
            
            
            
            let postObject = Post(userID: "\(self.user!)",
                                  caption: self.commentTextView.text,
                                  image: (snapshot.metadata?.downloadURL()?.absoluteString)!,
                                  location: self.locationTextView.text,
                                  username: self.currentUsername!) //1
            //            self.photoURLs.append(downloadURL())
            //            print(snapshot)
            postObject.objectId = "\(unsafeAddressOf(postObject))"
            
            //            let currentDate = NSDateComponents()
            //            postObject.dateString = "\(currentDate.year).\(currentDate.month).\(currentDate.day) \(currentDate.era)"
            //            postObject.day = currentDate.day
            //            postObject.month = currentDate.month
            //            postObject.minute = currentDate.minute
            //            postObject.second = currentDate.second
            //            postObject.hour = currentDate.hour
            ////            postObject.year = currentDate.year
            //            currentDate.timeZone
            //            let currentdate = NSDate()
            
            
            let postObjectID = postObject.objectId
            
            database.child(postObjectID!).setValue(["userID" : postObject.userID, "caption" : postObject.caption, "imageString" : postObject.image, "location" : postObject.location, "likes" : 0, "comments" : [], "username" : postObject.username])
            
            //database.childByAutoId().setValue(["urls": photoObject.imageString]) //3
            
            //let database = self.rootRefDB.child("users")
            
            //            let cUser = instaUser(username: self.usernameField.text!,
            //                                  email: user!.email!,
            //                                  profileDescription: "",
            //                                  profilePicture: "",
            //                                  realName: self.realNameField.text!)
            
            //            database.child(user!.uid).setValue(["username": cUser.username,
            //                "email": cUser.email, "profileDescription": cUser.profileDescription,
            //                "profilePicture": cUser.profilePicture, "realName": cUser.realName])
        }
        
        print("yeaa lets post this.")
    }
    //    func textFieldShouldReturn(textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //    }
    //    
    //    func textViewShouldEndEditing(textView: UITextView) -> Bool {
    //        if (textView.text == "\n") {
    //            textView.resignFirstResponder()
    //        }
    //        return true
    //    }
    
    
    
}
