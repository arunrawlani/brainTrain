//
//  DashboardViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 7/18/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import Parse

class DashboardViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var changePicture: UIButton!
    var photoTakingHelper: PhotoTakingHelper?
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
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
    
    
  /*  override func viewDidLoad(){
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        self.tableView.dataSource = self

        self.tableView.allowsSelection = false
        
        
    }*/

    override func viewDidLoad() {
   
        super.viewDidLoad()
        //Calling query from Parse
        let requestQuery = Request.query()
        requestQuery!.whereKey("fromUser", equalTo: PFUser.currentUser()!)
//        var user = PFUser.currentUser()
//
        requestQuery!.includeKey("toUser")
        requestQuery!.includeKey("fromUser")
        requestQuery!.includeKey("toTour")
        
        requestQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            self.scheduledTours = result as? [Request] ?? []
            self.tableView.reloadData()
            
            }
        var firstName: String = PFUser.currentUser()!["firstName"] as! String
        var lastName: String = PFUser.currentUser()!["lastName"] as! String
        var fullName: String = "\(firstName) \(lastName)"
        self.nameLabel.text = fullName
        var userImageFile: AnyObject? = PFUser.currentUser()!["userImage"]
        let data = userImageFile?.getData()
        self.userImage.image = UIImage(data: data!, scale: 1.0)
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
        self.userImage.layer.borderWidth = 1.0
        self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
        /*   //MADE THIS CHANGE AFTER THE HACKTHON
        //self.navigationItem.setHidesBackButton(true, animated: false)
        tableview.allowsSelection = false
        // Do any additional setup after loading the view. */
    
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

extension DashboardViewController: UITableViewDataSource{

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduledTours.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RequestCell") as! DashboardTableViewCell
        //Cell parameters:
       // if scheduledTours[indexPath.row].toTour!.tourName != nil {
        let test = scheduledTours[indexPath.row].toTour
        scheduledTours[indexPath.row].toTour!.fetchIfNeeded()
        cell.tourNameLabel.text = scheduledTours[indexPath.row].toTour!["tourName"] as? String
        //}
        cell.tourDateLabel.text = scheduledTours[indexPath.row].requestedDate
        cell.tourGuideLabel.text = scheduledTours[indexPath.row].toUser!.username
        cell.timeLabel.text = scheduledTours[indexPath.row].requestedTime
        if (!scheduledTours[indexPath.row].isApproved){
            cell.pendingLabel.hidden = false
            cell.approvedLabel.hidden = true
        }
        else{
            cell.pendingLabel.hidden = true
            cell.approvedLabel.hidden = false
        }
        cell.tourRequest = scheduledTours[indexPath.row]
        cell.confirmationLabel.hidden = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //TODO implement price range cell.rating = allBusinesses[indexPath.row].reviews
        return cell
    }
    
}


