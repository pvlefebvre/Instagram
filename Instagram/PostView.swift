//
//  PostView.swift
//  Instagram
//
//  Created by Paul Lefebvre on 6/18/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class PostView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var attributeBarView: UIView!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var userImageButton: UIButton!

    var view: UIView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        addSubview(view)
    }
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "PostView", bundle: bundle)
        view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }

}
