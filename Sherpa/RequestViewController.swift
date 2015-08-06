//
//  RequestViewController.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 8/5/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import Parse

class RequestViewController: UIViewController{
   
    @IBOutlet weak var tableView: UITableView!
    
    var requestedTour: [Request] = []
   
   override func viewDidLoad() {
    
        super.viewDidLoad()
        //Calling query from Parse
        let requestQuery = Request.query()
        requestQuery!.whereKey("toUser", equalTo: PFUser.currentUser()!)
        //        var user = PFUser.currentUser()
        //
        requestQuery!.includeKey("toUser")
        requestQuery!.includeKey("fromUser")
        requestQuery!.includeKey("toTour")
        
        requestQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            self.requestedTour = result as? [Request] ?? []
            self.tableView.reloadData()
            
        }
    }
}

extension RequestViewController: UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requestedTour.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as! RequestTableViewCell
        //Cell parameters:
        
        let test = requestedTour[indexPath.row].toTour
        println(test?.description)
        requestedTour[indexPath.row].toTour!.fetchIfNeeded()
        cell.tourNameLabel.text = requestedTour[indexPath.row].toTour!["tourName"] as? String
        cell.tourDateLabel.text = requestedTour[indexPath.row].requestedDate
        cell.touristLabel.text = requestedTour[indexPath.row].fromUser!.username
        cell.timeLabel.text = requestedTour[indexPath.row].requestedTime
        //cell.selectionStyle = UITableViewCellSelectionStyle.None
        //TODO implement price range cell.rating = allBusinesses[indexPath.row].reviews
         println("kya scene")
        return cell
    }
    
}