//
//  ActivityViewController.swift
//  dollarTree
//
//  Created by Praynaa Rawlani on 8/23/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import Parse

class ActivityViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var allActivity: [Activity] = []
    
    override func viewDidLoad() {
        let activityQuery = Activity.query()
        activityQuery!.whereKey("toUser", equalTo: PFUser.currentUser()!)
        
        activityQuery!.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            self.allActivity = result as? [Activity] ?? []
            self.tableView.reloadData()
            
        }
    }
    
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allActivity.count ?? 0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if (allActivity.count == 0) {
            var messageLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            messageLabel.text = "No activity yet"
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell") as! ActivityViewCell
        if (allActivity[indexPath.row].userImage == nil){
            cell.userImage.image = UIImage(named:"DisplayPicture")
        }
        else {
            var userImageFile: AnyObject? = allActivity[indexPath.row].userImage
            let data = userImageFile?.getData()
            cell.userImage.image = UIImage(data: data!, scale: 1.0)
        }
        cell.userName.text = allActivity[indexPath.row].userName
        cell.extraDetail.text = allActivity[indexPath.row].extraDetail
        cell.numberTrees.text = allActivity[indexPath.row].numberTrees
        
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width / 2
        cell.userImage.clipsToBounds = true
        cell.userImage.layer.borderWidth = 1.0
        cell.userImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
}
