//
//  RequestTableViewCell.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Parse


class RequestTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var approveMessage: UILabel!
    @IBOutlet weak var processingMessage: UILabel!
    @IBOutlet weak var rejectMessage: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var touristLabel: UILabel!
    @IBOutlet var tourDateLabel: UILabel!
    @IBOutlet var tourNameLabel: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var request: Request? = nil
    
    @IBAction func approvedPressed(sender: AnyObject) {
        
        self.approveButton.hidden = true
        self.processingMessage.hidden = false
        self.request!["isApproved"] = true
        request?.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if(success){
                //success
                println("Succesfully saved.")
                self.approveMessage.hidden = false
                self.processingMessage.hidden = true
            }
            else{
                //fail
                println("Failed to update isApproved.")
            }
        }
    }
    
}

