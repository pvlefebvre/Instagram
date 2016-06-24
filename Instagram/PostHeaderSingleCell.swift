//
//  PostHeaderSingleCell.swift
//  Instagram
//
//  Created by Lance Russ on 6/24/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class PostHeaderSingleCell: UITableViewCell {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
