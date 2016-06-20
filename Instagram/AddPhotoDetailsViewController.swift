//
//  AddPhotoDetailsViewController.swift
//  Instagram
//
//  Created by Lance Russ on 6/20/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit

class AddPhotoDetailsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var locationTextView: UITextView!
    
    var postImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = postImage
        commentTextView.delegate = self
        locationTextView.delegate = self
        
        imageView.clipsToBounds = true
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func onPostButtonPressed(sender: UIButton) {
        
        print("yeaa lets post this.")
    }
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    func textViewShouldEndEditing(textView: UITextView) -> Bool {
//        if (textView.text == "\n") {
//            textView.resignFirstResponder()
//        }
//        return true
//    }
    


}
