//
//  DashboardTableCell.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Parse

protocol dashboard {
    func itemPressed()
}

class DashboardTableViewCell: UITableViewCell {
    
    var delegate: dashboard? = nil
    
    @IBOutlet weak var ranImage: UIImageView!
    @IBOutlet weak var levelDescription: UILabel!
 
    @IBOutlet weak var brainValue: UILabel!

    @IBOutlet weak var reactionTime: UILabel!
 @IBAction func tourCancelled(sender: AnyObject) {
    
   /* self.cancelButton.hidden = true
    self.timelineButton.hidden = true
    self.tourRequest!["isCancelled"] = true
    tourRequest?.saveInBackgroundWithBlock{
        (success: Bool, error: NSError?) -> Void in
        if(success){
            //success
            println("Succesfully saved.")
            self.confirmationLabel.hidden = false
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.isGloballyCancelled = true
        }
        else{
            //fail
            println("Failed to update isCancelled.")
        }
    }*/
    println("Show Details")
}
}