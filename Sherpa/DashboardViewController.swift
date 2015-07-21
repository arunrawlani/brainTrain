//
//  DashboardViewController.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/18/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    @IBOutlet var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       //MADE THIS CHANGE AFTER THE HACKTHON
        //self.navigationItem.setHidesBackButton(true, animated: false)
        tableview.allowsSelection = false
        // Do any additional setup after loading the view.
        
    let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    
    }
    
    let data = DataDashBoard()
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.scheduledTours.count
    }
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DashboardTableCell
        // Configure the cell...
        cell.backgroundColor = UIColor.clearColor()
        cell.timeLabel.text = data.scheduledTours[indexPath.row].tourTime
        cell.timeAMPMLabel.text = data.scheduledTours[indexPath.row].tourTimeAmorPM
        cell.tourNameLabel.text = data.scheduledTours[indexPath.row].tourName
        cell.tourGuideLabel.text = data.scheduledTours[indexPath.row].tourGuide
        cell.tourDateLabel.text = data.scheduledTours[indexPath.row].tourDate
        return cell
    }

}
