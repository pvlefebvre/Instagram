//
//  PhotoTakeViewController.swift
//  Instagram
//
//  Created by Lance Russ on 6/19/16.
//  Copyright © 2016 Paul Lefebvre. All rights reserved.
//

import UIKit
import Firebase

class PhotoTakeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var imagePicker:UIImagePickerController!
    var currentFilter: CIFilter!
    var context: CIContext!
    var currentImage: UIImage!
    var originalImage: UIImage!
    
    let rootRefDB = FIRDatabase.database().reference() //reference to the root database
    let rootRefStorage = FIRStorage.storage().reference()
    
    var orientation: UIImageOrientation = .Up //1

    var processedImage = UIImage()

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentCamera()
        
        imageView.image = UIImage(named: "takeapic")
        imageView.clipsToBounds = true
        originalImage = UIImage(named: "takeapic")
        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .Camera
//        presentViewController(imagePicker, animated: true, completion: nil)
        
        context = CIContext(options: nil)

    }
    
    func presentCamera() {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func onTakePhotoButtonPressed(sender: UIButton) {
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        filtersCollectionView.reloadData()
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.clipsToBounds = true
        orientation = (imageView.image?.imageOrientation)!
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCellsID", forIndexPath:indexPath) as? FilterCollectionViewCell {
        
        cell.cellImageView.image = originalImage
        cell.cellImageView.clipsToBounds = true
//        var newImageOrientation = imageView.image?.imageOrientation
        currentImage = originalImage
        let cellImage = currentImage
        
        if let filterCell = FilterCell(rawValue: indexPath.row) {
            cell.cellLabel.text = filterCell.text()
            currentFilter = filterCell.filter()
            
            
            let beginImage = CIImage(image: cellImage!)
            
            //probably gets thrown because the first one does not
            if indexPath.row != 0 {
                
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            cell.cellImageView.image = processedImage
                
            //cell.cellImageView.image?.imageOrientation = newImageOrientation
                
            }
            
            }
            return cell

        } else  {
            return FilterCollectionViewCell()
        }
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {currentFilter.setValue(1.0, forKey: kCIInputIntensityKey)}
        //if inputKeys.contains(kCIInputRadiusKey) {currentFilter.setValue(1.0 * 80, forKey: kCIInputRadiusKey)}
        //if inputKeys.contains(kCIInputScaleKey) {currentFilter.setValue(8, forKey: kCIInputScaleKey)}
        //if inputKeys.contains(kCIInputCenterKey) {currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)}
        
        let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        processedImage = UIImage(CGImage: cgimg, scale:1, orientation: orientation) //3
    }
    

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let filterCell = FilterCell(rawValue: indexPath.row) {
            
            currentFilter = filterCell.filter()
            
            let beginImage = CIImage(image: originalImage)
            
            if indexPath.row != 0 {
                
                currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
                applyProcessing()
                imageView.image = processedImage
                
            } else {
                imageView.image = originalImage
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? AddPhotoDetailsViewController {
            vc.postImage = imageView.image
        }
    }
    
    @IBAction func onAcceptButtonPressed(sender: UIButton) {
        if originalImage != UIImage(named: "takeapic") {
        performSegueWithIdentifier("ToDetailAddScreen", sender: nil)
        }
    }
    
    
    

}
