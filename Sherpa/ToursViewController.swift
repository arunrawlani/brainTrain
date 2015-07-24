//
//  ToursViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 7/18/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import Parse

class ToursViewController: UIViewController, UITableViewDelegate , UITableViewDataSource, tour{
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var MainCityLabel: UILabel!
    @IBOutlet var MainCityImageview: UIImageView!
    var mainCityLabelText: String = ""
    var mainGraphicImageFileName: String = ""
    var citySelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(mainCityLabelText)
        MainCityLabel.text = mainCityLabelText
        MainCityImageview.image = UIImage(named: mainGraphicImageFileName)
        tableview.allowsSelection = false
    }

    let data = DataTours()
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if citySelected == 0 {
            return data.toursNY.count
        }
        else if citySelected == 1 {
            return data.toursVegas.count
        }
        else {
            return data.toursLA.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ToursTableCell
        cell.backgroundColor = UIColor.clearColor()
        cell.delegate = self
        if citySelected == 0 {
            cell.imageFilename = data.toursNY[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursNY[indexPath.row].circularImage)
            cell.costLabel.text = data.toursNY[indexPath.row].cost
            cell.languagesName.text = data.toursNY[indexPath.row].languages
            cell.TourName.text = data.toursNY[indexPath.row].tourName
            
        }
        else if citySelected == 1 {
            cell.imageFilename = data.toursVegas[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursVegas[indexPath.row].circularImage)
            cell.costLabel.text = data.toursVegas[indexPath.row].cost
            cell.languagesName.text = data.toursVegas[indexPath.row].languages
            cell.TourName.text = data.toursVegas[indexPath.row].tourName
        }
        else {
            cell.imageFilename = data.toursLA[indexPath.row].cityImage
            cell.userImageView.image = UIImage(named: data.toursLA[indexPath.row].circularImage)
            cell.costLabel.text = data.toursLA[indexPath.row].cost
            cell.languagesName.text = data.toursLA[indexPath.row].languages
            cell.TourName.text = data.toursLA[indexPath.row].tourName
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

        
    }
    func goToOverview(tourName: String, imageName: String, costLabel: String){
        self.tourName = tourName
        self.imageName = imageName
        self.costLabel = costLabel
        performSegueWithIdentifier("goToTourOverview", sender: self)
    }

}
