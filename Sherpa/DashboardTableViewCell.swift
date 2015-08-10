//
//  DashboardTableCell.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/18/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Parse

protocol dashboard {
    func itemPressed()
}

class DashboardTableViewCell: UITableViewCell {
    
    var delegate: dashboard? = nil
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tourGuideLabel: UILabel!
    @IBOutlet var tourDateLabel: UILabel!
    @IBOutlet var tourNameLabel: UILabel!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timelineButton: UIButton!
    @IBOutlet weak var confirmationLabel: UILabel!
    
    var tourRequest: Request? = nil

 @IBAction func tourCancelled(sender: AnyObject) {
    
    self.cancelButton.hidden = true
    self.timelineButton.hidden = true
    self.tourRequest!["isCancelled"] = true
    tourRequest?.saveInBackgroundWithBlock{
        (success: Bool, error: NSError?) -> Void in
        if(success){
            //success
            println("Succesfully saved.")
            self.confirmationLabel.hidden = false
        }
        else{
            //fail
            println("Failed to update isCancelled.")
        }
    }
}
}