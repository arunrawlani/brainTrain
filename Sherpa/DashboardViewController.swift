//
//  DashboardViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import Parse

class DashboardViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changePicture: UIButton!
    var photoTakingHelper: PhotoTakingHelper?
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    @IBOutlet weak var pointsEarned: UILabel!
    @IBOutlet weak var treesPlanted: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var scheduledTours: [Request] = []
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func photoMenu(sender: AnyObject) {
        println("Take photo")
        takePhoto()
    }
    let transitionManager = TransitionManager()
    
    
 /*   override func viewDidLoad(){
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.tableView.dataSource = self

        self.tableView.allowsSelection = false
        
        
    } */

    override func viewDidLoad() {
   
        super.viewDidLoad()
        //Calling query from Parse
//        var isCancelledQuery: PFQuery?
//        
//        let requestQuery = Request.query()
//        requestQuery!.whereKey("fromUser", equalTo: PFUser.currentUser()!)
//        
//        if let requestQuery = requestQuery{
//        isCancelledQuery = PFQuery.orQueryWithSubqueries([requestQuery])
//            isCancelledQuery!.whereKey("isCancelled", equalTo: false)
//
//        isCancelledQuery!.includeKey("toUser")
//        isCancelledQuery!.includeKey("fromUser")
//        isCancelledQuery!.includeKey("toTour")
//        }
//        
//        isCancelledQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
//            
//            self.scheduledTours = result as? [Request] ?? []
//
//            }
        var firstName: String = PFUser.currentUser()!["firstName"] as! String
        var lastName: String = PFUser.currentUser()!["lastName"] as! String
        var fullName: String = "\(firstName) \(lastName)"
        var points = PFUser.currentUser()!["pointsEarned"] as! Int
        self.pointsEarned.text = "\(points)"
        var trees = PFUser.currentUser()!["treesPlanted"] as! Int
        self.treesPlanted.text = "\(trees)"
        self.nameLabel.text = fullName
        if (PFUser.currentUser()!["userImage"] == nil){
            self.userImage.image = UIImage(named:"DisplayPicture")
        }
        else {
        var userImageFile: AnyObject? = PFUser.currentUser()!["userImage"]
        let data = userImageFile?.getData()
            self.userImage.image = UIImage(data: data!, scale: 1.0)
        }
        
        //manipulating the user image only
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
        self.userImage.layer.borderWidth = 1.0
        self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
      
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if (appDelegate.requestSubmitted == true || appDelegate.isGloballyCancelled == true)
        {
        
            var isCancelledQuery: PFQuery?
            
            let requestQuery = Request.query()
            requestQuery!.whereKey("fromUser", equalTo: PFUser.currentUser()!)
            
            if let requestQuery = requestQuery{
                isCancelledQuery = PFQuery.orQueryWithSubqueries([requestQuery])
                isCancelledQuery!.whereKey("isCancelled", equalTo: false)
                
                isCancelledQuery!.includeKey("toUser")
                isCancelledQuery!.includeKey("fromUser")
                isCancelledQuery!.includeKey("toTour")
            }
            
            isCancelledQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
                
                self.scheduledTours = result as? [Request] ?? []
              
                
            }
            
        }
        else {
            println("Request submitted has not been changed")
    }
    }
    
    func takePhoto() {
        // instantiate photo taking class, provide callback for when photo  is selected
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            println("received a callback")
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let imageFile = PFFile(data: imageData)
            imageFile.saveInBackground()
            
        //allows image to be sstored in the background even if app is closed
            self.photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            
            imageFile.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                // 3
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            let user = PFUser.currentUser()
            user!["userImage"] = imageFile
            user!.saveInBackgroundWithBlock(nil)
            self.userImage.image = image
        }
    }
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as! UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
       // toViewController.transitioningDelegate = self.transitionManager
        
    }

}




