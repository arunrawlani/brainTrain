//
//  TableViewForExplore.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/18/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//
import UIKit
import Parse

class TableViewForExplore: UITableViewController, explore {
    
    let data = DataExplore()
    var textOfCity: String = ""
    var imageOfCity: String = ""
    var city: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.createSinchClient(PFUser.currentUser()!.objectId!)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.places.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ExploreTableCell
        // Configure the cell...
        cell.delegate = self
        cell.imageFilename = data.places[indexPath.row].imagename
        cell.cityNameLabel.text = data.places[indexPath.row].heading
        cell.cityImageView.image = UIImage(named: cell.imageFilename)
        cell.cityId = indexPath.row
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToTours" {
            let secondVC:ToursViewController = segue.destinationViewController as! ToursViewController
            secondVC.mainCityLabelText = textOfCity
            secondVC.mainGraphicImageFileName = imageOfCity
            secondVC.citySelected = city
        }

    }
    func pressedImage(cityLabel: String, imageFilename: String, selectedCity: Int) {
        textOfCity = cityLabel
        imageOfCity = imageFilename
        city = selectedCity
        performSegueWithIdentifier("goToTours", sender: self)
    }
}
