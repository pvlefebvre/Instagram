//
//  PostHeaderCell.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/20/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {

    @IBOutlet weak var profileName: UIButton!
    @IBOutlet weak var profilePicture: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
