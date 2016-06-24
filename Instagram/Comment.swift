//
//  Comment.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/17/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class Comment: NSObject {

    var postID: NSString
    var userID: NSString
    var username: NSString
    var message: NSString
    var objectId: String? = nil
    
    init(postID: NSString, userID: NSString, username: NSString, message: NSString) {
        
        self.postID = postID
        self.userID = userID
        self.username = username
        self.message = message
        
    }
}
