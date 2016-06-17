//
//  Post.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/17/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class Post: NSObject {
    let picture: Picture?
    let comments: [Comment]? = nil
    let account: Account?
    
    init(picture: Picture, account: Account) {
        self.picture = picture
        self.account = account
    }
}
