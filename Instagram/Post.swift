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
    let account: Account?
    let caption: String? = nil
    let location: String? = nil
    let image: UIImage? = nil
    
    init(account: Account) {
        self.account = account
    }
}
