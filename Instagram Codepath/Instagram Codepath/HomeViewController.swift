//
//  HomeViewController.swift
//  Instagram Codepath
//
//  Created by Ricardo Vila on 3/6/16.
//  Copyright © 2016 Ricardo Vila. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var media = [PFObject]?()
    
    var image: UIImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //imagePicker.delegate = self
        //imagePicker.allowsEditing = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getPics { (images, error) -> () in
            self.media = images
            self.tableView.reloadData()
        }
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if media?.count > 0 {
            return (media?.count)!
        } else {
            return 0
        }    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! postCell
        
        
        let image = self.media?[indexPath.row]
        
        if image != nil
        {
            cell.captionLabel.text = image!["caption"] as? String
                        image!["media"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.photoView.image = image
                }
            }
        }

        
        /** if image != nil {
            cell.captionLabel.text = image!["caption"] as? String
            
            image!["media"].getDataInBackgroundWithBlock { (imageData: NSData?, error:NSError?) -> Void in
                if error == nil {
                    let image = UIImage(data: imageData!)
                    cell.photoView.image = image
                }
            }
        }**/
        return cell
    }
    
    
    /** @IBAction func imageLibrary(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        
        presentViewController(imagePicker, animated: true, completion: nil)
        performSegueWithIdentifier("editImage", sender: self)
    }
    **/
    
    @IBAction func imageCamera(sender: AnyObject) {
       /**  imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
        **/
        performSegueWithIdentifier("editImage", sender: self)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOutInBackground()
        dismissViewControllerAnimated(false, completion: nil)
        print("user logged out")
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func getPics(completion: (media: [PFObject]?, error: NSError?)-> Void) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                completion(media: media, error: nil)
                print("media retrieved")
            } else {
                print("couldn't retrieve media")
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        //Connect to the API to have the last update
        getPics() { (media, error) -> Void in
            self.media = media
            self.tableView.reloadData()
        }
        
        //update the collection data source
        refreshControl.endRefreshing()
    }

    /** override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editImage" {
            let vc = segue.destinationViewController as! PictureViewController
            vc.uploadedPhoto = self.image
        }
    }**/

}
