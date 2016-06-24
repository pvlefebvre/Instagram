//
//  Comment.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/17/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class Comment: NSObject {

    var userID: NSString
    var username: NSString
    var message: NSString
    
    init(userID: NSString, username: NSString, message: NSString) {
        
        self.userID = userID
        self.username = username
        self.message = message
        
    }
}
