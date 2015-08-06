//
//  RequestTableViewCell.swift
//  Sherpa
//
//  Created by Arun Rawlani on 8/6/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Parse


class RequestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var approveMessage: UILabel!
    @IBOutlet weak var rejectMessage: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var touristLabel: UILabel!
    @IBOutlet var tourDateLabel: UILabel!
    @IBOutlet var tourNameLabel: UILabel!
    
    @IBAction func approvedPressed(sender: AnyObject) {
        
        self.rejectButton.hidden = true
        self.approveButton.hidden = true
        self.approveMessage.hidden = false
        self.rejectMessage.hidden = true
    }
    
    @IBAction func rejectedPressed(sender: AnyObject) {
        
        self.rejectButton.hidden = true
        self.approveButton.hidden = true
        self.approveMessage.hidden = true
        self.rejectMessage.hidden = false
    }
    
}
