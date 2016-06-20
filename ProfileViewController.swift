//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Tyler Italiano on 6/19/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionView, UICollectionViewCell, UICollectionViewFlowLayout
    @IBAction func editProfileButton(sender: AnyObject) {
    }
    @IBOutlet weak var postsCounterLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCounterLabel: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileDescriptionLabel: UITextView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let cell = "ProfilePhotoCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfilePhotoCell", forIndexPath: indexPath) 
        cell.backgroundColor = UIColor.redColor()
        return cell
        
        
    }
    
    
}
