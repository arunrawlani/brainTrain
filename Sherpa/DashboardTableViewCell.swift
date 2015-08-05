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
    @IBOutlet var timeAMPMLabel: UILabel!
}
