//
//  ToursViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 7/18/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import Parse

class ToursViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, tour {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var MainCityLabel: UILabel!
    @IBOutlet var MainCityImageview: UIImageView!
    var mainCityLabelText: String = ""
    var mainGraphicImageFileName: String = ""
    var citySelected: Int = 0
    
    var toursNY: [Tour] = []
    var toursLV: [Tour] = []
    var toursLA: [Tour] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(mainCityLabelText)
        MainCityLabel.text = mainCityLabelText
        MainCityImageview.image = UIImage(named: mainGraphicImageFileName)
        tableview.allowsSelection = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //NEW YORK
        let NYquery = PFQuery(className: "Tour")
        NYquery.whereKey("city", equalTo: "New York")
        
        NYquery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            //Parse hands us an [AnyObject] array which we cast to [Tour]. If casting not possible store empty array
            self.toursNY = result as? [Tour] ?? []
            self.tableview.reloadData()
            
        }
        
        //LAS VEGAS
        let LVquery = PFQuery(className: "Tour")
        LVquery.whereKey("city", equalTo: "Las Vegas")
        
        LVquery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            //Parse hands us an [AnyObject] array which we cast to [Tour]. If casting not possible store empty array
            self.toursLV = result as? [Tour] ?? []
            self.tableview.reloadData()
            
        }
        
        //LOS ANGELES
        let LAquery = PFQuery(className: "Tour")
        LAquery.whereKey("city", equalTo: "Los Angeles")
        
        LAquery.findObjectsInBackgroundWithBlock {(result: [AnyObject]?, error: NSError?) -> Void in
            
            //Parse hands us an [AnyObject] array which we cast to [Tour]. If casting not possible store empty array
            self.toursLA = result as? [Tour] ?? []
            self.tableview.reloadData()
            
        }
    }

    let data = DataTours()
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if citySelected == 0 {
            return toursNY.count
        }
        else if citySelected == 1 {
            return toursLV.count
        }
        else {
            return toursLA.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ToursTableCell
        cell.backgroundColor = UIColor.clearColor()
        cell.delegate = self
        
        //Changing the display to circular and adding a border
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.size.width / 2
        cell.userImageView.clipsToBounds = true
        cell.userImageView.layer.borderWidth = 1.0
        cell.userImageView.layer.borderColor = UIColor.whiteColor().CGColor
       
        if citySelected == 0 { //NEW YORK
        /* cell.imageFilename = data.toursNY[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursNY[indexPath.row].circularImage)
            cell.costLabel.text = data.toursNY[indexPath.row].cost
            cell.languagesName.text = data.toursNY[indexPath.row].languages
            cell.TourName.text = data.toursNY[indexPath.row].tourName */
            
          //From the in-built library
          cell.imageFilename = data.toursNY[indexPath.row].cityImage
          cell.userImageView.image = UIImage(named: data.toursNY[indexPath.row].circularImage)
            
         //From PARSE
          cell.costLabel.text = toursNY[indexPath.row].cost
          cell.TourName.text = toursNY[indexPath.row].tourName
          let languages = toursNY[indexPath.row].langOffered!
            .reduce("") {(total, language)in
                if (total == ""){
                return total + "\(language)"
                }
                else{
                   return  total + ", \(language)"
                }
            }
            cell.languagesName.text = languages
           
            
        }
        else if citySelected == 1 { //LAS VEGAS
           /* cell.imageFilename = data.toursVegas[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursVegas[indexPath.row].circularImage)
            cell.costLabel.text = data.toursVegas[indexPath.row].cost
            cell.languagesName.text = data.toursVegas[indexPath.row].languages
            cell.TourName.text = data.toursVegas[indexPath.row].tourName*/
            
            //From built-in library
            cell.imageFilename = data.toursVegas[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursNY[indexPath.row].circularImage)
            
            //From PARSE
            cell.costLabel.text = toursLV[indexPath.row].cost
            cell.TourName.text = toursLV[indexPath.row].tourName
            let languages = toursLV[indexPath.row].langOffered!
                .reduce("") {(total, language)in
                    if (total == ""){
                        return total + "\(language)"
                    }
                    else{
                        return  total + ", \(language)"
                    }
            }
            cell.languagesName.text = languages
        }
            
        else { //LOS ANGELES
            /*cell.imageFilename = data.toursLA[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursLA[indexPath.row].circularImage)
            cell.costLabel.text = data.toursLA[indexPath.row].cost
            cell.languagesName.text = data.toursLA[indexPath.row].languages
            cell.TourName.text = data.toursLA[indexPath.row].tourName*/
            
           //From built-in library
            cell.imageFilename = data.toursLA[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursLA[indexPath.row].circularImage)
            
            //From PARSE
            cell.costLabel.text = toursLA[indexPath.row].cost
            cell.TourName.text = toursLA[indexPath.row].tourName
            let languages = toursLA[indexPath.row].langOffered!
                .reduce("") {(total, language)in
                    if (total == ""){
                        return total + "\(language)"
                    }
                    else{
                        return  total + ", \(language)"
                    }
            }
            cell.languagesName.text = languages
        }
        return cell
    }
    
    var tourName: String = ""
    var imageName: String = ""
    var costLabel: String = ""
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToTourOverview" {
            let secondVC:TourOverviewViewController = segue.destinationViewController as! TourOverviewViewController
            secondVC.tourname = tourName
            secondVC.ImageName = imageName
            secondVC.tourPriceamt = costLabel
            
        }
        else if segue.identifier == "goToReserveTour"{
            let reserveVC: ReserveViewController = segue.destinationViewController as! ReserveViewController
            reserveVC.tourName = tourName
            reserveVC.tourCost = costLabel
        }

        
    }
   /* func goToOverview(tourName: String, imageName: String, costLabel: String){
        self.tourName = tourName
        self.imageName = imageName
        self.costLabel = costLabel
        performSegueWithIdentifier("goToTourOverview", sender: self)
    }*/
    
    func goToOverview(tourName: String, imageName: String, costLabel: String) {
        self.tourName = tourName
        self.imageName = imageName
        self.costLabel = costLabel
        performSegueWithIdentifier("goToReserveTour", sender: self)
    }

}
