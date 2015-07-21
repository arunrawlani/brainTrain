//
//  TimelineViewController.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/19/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet var timelineImage: UIImageView!
    var whichTimeline: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if whichTimeline == "LosAngeles" {
            timelineImage.image = UIImage(named: "Venice Beach")
        }
        else if whichTimeline == "LasVegas" {
            timelineImage.image = UIImage(named: "Bellagio Resort Timeline Copy")
        }
        else {
            timelineImage.image = UIImage(named: "Central Park Timeline")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
