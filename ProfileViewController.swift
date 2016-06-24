//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/19/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Kingfisher

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBAction func editProfileButton(sender: AnyObject) {}
    @IBOutlet weak var postsCounterLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCounterLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileDescriptionLabel: UITextView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let rootRefDB = FIRDatabase.database().reference()
    let rootRefStorage = FIRStorage.storage().reference()
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    let user = FIRAuth.auth()?.currentUser?.uid
    var currentUsername: String?
    
    var newArray = [NSURL?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        
        screenSize = UIScreen.mainScreen().bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = profileCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            let totalSnap = (snap.value as? NSDictionary)!
            if let users = totalSnap["users"] as? NSDictionary {
                //                let valueDict = users
                self.currentUsername = users.valueForKey("\(self.user!)")!.valueForKey("username")! as? String
                self.title = "\(self.currentUsername!)"
            }
        }
        
        rootRefDB.observeSingleEventOfType(.Value) { (snap: FIRDataSnapshot) in
            self.newArray.removeAll()
            let snapshotAll = (snap.value as? NSDictionary)!
            if let posts = snapshotAll["posts"] as? NSDictionary {
//                if let urls = takenPhotos["urls"] as? NSDictionary {
                
                    for (_, value) in posts {
                        let valueDict = value as! NSDictionary
                        
                        if valueDict.valueForKey("username")! as! String == "\(self.currentUsername!)" {
                            let finalPost = valueDict.valueForKey("imageString")! as! String
                            let newURL = NSURL(string: finalPost)
                            self.newArray.append(newURL!)
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.postsCounterLabel.text = "\(self.newArray.count)"
                        self.profileCollectionView.reloadData()
                    })
                }
            }
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if newArray.count == 0 {
            return 0
        } else {
            print(newArray.count)
            return newArray.count
        }
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfilePhotoCell", forIndexPath: indexPath) as! ProfileGridCells
        
        cell.backgroundColor = UIColor.whiteColor()
        collectionView.backgroundColor = UIColor.whiteColor()
        
        if let url = self.newArray[indexPath.row] {
            cell.profileGridImageView.kf_setImageWithURL(NSURL(string: "\(url)")!, placeholderImage: nil)
        }
        
        cell.frame.size.width = screenWidth / 3

        
        return cell
        
    }
    
    
}
