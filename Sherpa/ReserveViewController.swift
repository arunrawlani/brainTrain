//
//  ReserveViewController.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 7/29/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import Foundation
import AKPickerView_Swift
import DatePickerCell
import Parse

class ReserveViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var timePicker: AKPickerView!
    @IBOutlet weak var reviewNumLabel: UILabel!
    
    @IBOutlet weak var requestButton: UIButton!
    var requestPressedCounter: Int = 1
    
   
    
    var cells: NSArray = []
    var languages = ["Mandarin", "Japanese", "Hindi", "Urdu", "Saitama", "Chiba", "Hyogo", "Hokkaido", "Fukuoka", "Shizuoka"]
    var time = ["9:30", "10:30", "11:30", "12:30", "1:30", "2:30", "3:30"]
    
     var tourCost: String = "" //costLabel
     var tourName: String = "" //nameLabel
     var tourSum: String = "" //sumLabel
     var tourLang: [String] = [] //pickerView
     var tourTimes: [String] = [] //timePicker
     var reviewsNum: Int = 0 //reviewNumLabel
     var selectedLanguage: String = ""
     var selectedTime: String = ""
     var selectedTour : Tour?
     var createdBy: PFUser?
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
   let transitionManager = TransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
      
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        
        self.pickerView.tag = 1
        self.timePicker.tag = 2
        
        // The DatePickerCell.
        let datePickerCell = DatePickerCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        // Cells is a 2D array containing sections and rows.
        datePickerCell.contentView.backgroundColor = UIColor.clearColor()
        
        cells = [[datePickerCell]]

        
        self.pickerView.font = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.pickerView.textColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        self.pickerView.highlightedFont = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.pickerView.highlightedTextColor = UIColor(red: 229.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 1.0)
        self.pickerView.textColor = UIColor.whiteColor()
        self.pickerView.interitemSpacing = 17.0
        self.pickerView.viewDepth = 1000.0
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        
        self.timePicker.font = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.timePicker.textColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        self.timePicker.highlightedFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.timePicker.highlightedTextColor = UIColor(red: 229.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 1.0)
        self.timePicker.textColor = UIColor.whiteColor()
        self.timePicker.interitemSpacing = 17.0
        self.timePicker.viewDepth = 1000.0
        self.timePicker.pickerViewStyle = .Wheel
        self.timePicker.maskDisabled = false
        self.timePicker.reloadData()
        
        nameLabel.text = tourName
        costLabel.text = tourCost
        sumLabel.text = tourSum
        reviewNumLabel.text = "(\(reviewsNum))"
        self.languages = tourLang
        self.time = tourTimes
        
        self.selectedLanguage = "None"
        self.selectedTime = "None"
       
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // this gets a reference to the screen that we're about to transition to
        var toViewController = segue.destinationViewController.topViewController as! ReviewViewController
        toViewController.reviewedTour = self.selectedTour
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        // toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        
        var arrayCount: Int
        
        if(pickerView.tag == 1){
        arrayCount = self.languages.count
        }
        else{
            arrayCount = self.time.count
        }
        
        return arrayCount
    }
    
    
    /*
    
    Image Support
    -------------
    Please comment '-pickerView:titleForItem:' entirely and
    uncomment '-pickerView:imageForItem:' to see how it works.
    
    */
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        
        var title: String
        
        if(pickerView.tag == 1){
        title = self.languages[item]
        }
        else{
          title = self.time[item]
        }
        
    return title
        
    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        
        var image: UIImage
        
        if(pickerView.tag == 1){
        image = UIImage(named: self.languages[item])!
        }
        else{
         image = UIImage(named: self.time[item])!
        }
        
        return image
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        if(pickerView.tag == 1){
        self.selectedLanguage = self.languages[item]
        println("You selected \(selectedLanguage)")
        }
        else{
            self.selectedTime = self.time[item]
            println("You selected \(selectedTime)")
        }
    }
    
    
    @IBAction func requestButtonPressed(sender: UIButton) {
        if requestPressedCounter == 1 {
            if (self.selectedLanguage == "None" || self.selectedTime == "None"){
                //GIVES AN ERROR MESSAGE
                println("Stop baby")
            }
            else{ //User has selected time, date and language
                sender.backgroundColor = UIColor.grayColor()
                var request = PFObject(className: "RequestTour")
                request["requestedTime"] = self.selectedTime
                request["requestedLang"] = self.selectedLanguage
                request["fromUser"] = PFUser.currentUser()
                request["isApproved"] = false
                request["toTour"] = self.selectedTour
                request["toUser"] = self.createdBy
                request["isRejected"] = false
                request["isCancelled"] = false
                request.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
                    if (success){
                        //do good shit
                    }
                    else{
                        //cry bitch
                    }
                }
            }
        }
        else {
            //gogo
        }
        requestPressedCounter++
        
    }
    
}

 

 extension ReserveViewController: UITableViewDataSource{
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Get the correct height if the cell is a DatePickerCell.
        var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if (cell.isKindOfClass(DatePickerCell)) {
            return (cell as! DatePickerCell).datePickerHeight()
        }
        
        return 44//tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect automatically if the cell is a DatePickerCell.
        var cell = self.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if (cell.isKindOfClass(DatePickerCell)) {
            println("gogogo")
            var datePickerTableViewCell = cell as! DatePickerCell
            datePickerTableViewCell.selectedInTableView(tableView)
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1//cells.count
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//cells[section].count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row] as! UITableViewCell
    }
}

