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
    
    var scheduledTours: [Request] = []
    
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
        
        /*   //MADE THIS CHANGE AFTER THE HACKTHON
        //self.navigationItem.setHidesBackButton(true, animated: false)
        tableview.allowsSelection = false
        // Do any additional setup after loading the view. */
    
    }
    
    
 /*   let data = DataDashBoard()
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
*/
    

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
        println(test?.description)
        scheduledTours[indexPath.row].toTour!.fetchIfNeeded()
        cell.tourNameLabel.text = scheduledTours[indexPath.row].toTour!["tourName"] as? String
        //}
        cell.tourDateLabel.text = scheduledTours[indexPath.row].requestedDate
        cell.tourGuideLabel.text = scheduledTours[indexPath.row].toUser!.username
        cell.timeLabel.text = scheduledTours[indexPath.row].requestedTime
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //TODO implement price range cell.rating = allBusinesses[indexPath.row].reviews
        return cell
    }
    
}


