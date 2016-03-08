//
//  PictureViewController.swift
//  Instagram Codepath
//
//  Created by Ricardo Vila on 3/6/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit
import Parse

class PictureViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    var ximage = UIImage()
    var uploadedPhoto = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // photoView.image = uploadedPhoto
        // Do any additional setup after loading the view.
        
        photoView.image = ximage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resizeImg(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func cancelPost(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPost(sender: AnyObject) {
        let image = resizeImg(photoView.image!, newSize: CGSizeMake(200,200))
        UserMedia.postUserImage(image, withCaption: captionField.text, withCompletion: nil)
        print("posted pic")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        ximage = pickedImage
        print("Image was picked")
        photoView.image = ximage
        
        dismissViewControllerAnimated(false, completion: nil)
        
    }

    @IBAction func imageLibrary(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func imageCamera(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
