//
//  Post.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/17/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    let comments: [Comment]? = nil
    let account: Account? = nil
    var userID: NSString
    var caption: NSString
    var location: NSString
    var image: NSString
    var likeCount: NSNumber = 0
    var objectId: String? = nil
//    var dateString: NSString = ""
    
    init(userID: NSString, caption: NSString, image: NSString, location: NSString) {
        
        self.caption = caption
        self.image = image
        self.location = location
        self.userID = userID
//        self.likeCount = 0
//        self.objectId = nil
        
    }
}
