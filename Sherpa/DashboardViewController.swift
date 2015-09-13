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
    

    @IBOutlet weak var tableView: UITableView!
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
    
    
    var allSession: [Session] = []
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

        
        let activityQuery = Session.query()
        activityQuery!.whereKey("toUser", equalTo: PFUser.currentUser()!)
        
        activityQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            self.allSession = result as? [Session] ?? []
            self.tableView.reloadData()
            
        }
        
        var firstName: String = PFUser.currentUser()!["firstName"] as! String
        var lastName: String = PFUser.currentUser()!["lastName"] as! String
        var fullName: String = "\(firstName) \(lastName)"
        
      
        
    
    }
    
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as! UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
       // toViewController.transitioningDelegate = self.transitionManager
        
    }

}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(allSession.count)
        return self.allSession.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if (allSession.count == 0) {
            var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.text = "No sessions recorded"
            messageLabel.textColor = UIColor.whiteColor()
            messageLabel.font = UIFont(name: "Avenir Next", size: 27)
            messageLabel.numberOfLines = 1
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }
        else {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DashboardCell") as! DashboardTableViewCell
        cell.levelDescription.text = allSession[indexPath.row].levelDescription
        cell.reactionTime.text = allSession[indexPath.row].reactionTime
        cell.brainValue.text = allSession[indexPath.row].brainValue
        
        cell.ranImage.layer.cornerRadius = cell.ranImage.frame.size.width / 2
        cell.ranImage.clipsToBounds = true
        cell.ranImage.layer.borderWidth = 1.0
        cell.ranImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}




