//
//  ReserveViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import AKPickerView_Swift
import Parse

class ReserveViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate {
    
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var timePicker: AKPickerView!
    @IBOutlet weak var reviewNumLabel: UILabel!
  //  @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var mainCityPicture: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var requestButton: UIButton!
    var requestPressedCounter: Int = 1
    
    var popDatePicker : PopDatePicker?
    
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
     var avgRating: Int?
     var mainImage: UIImage?
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
   let transitionManager = TransitionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainCityPicture.image = mainImage
        
     //   popDatePicker = PopDatePicker(forTextField: dateLabel)
     //   dateLabel.delegate = self
     //   dateLabel.textColor = UIColor(red: 220.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 1.0)
     //   dateLabel.attributedPlaceholder = NSAttributedString(string:"Tap here to Select",
     //   attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
     //   dateLabel.borderStyle = .None
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        
        self.pickerView.tag = 1
        self.timePicker.tag = 2
        
        
        self.pickerView.font = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.pickerView.textColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        self.pickerView.highlightedFont = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.pickerView.highlightedTextColor = UIColor(red: 55.0/256.0, green: 198.0/256.0, blue: 144.0/256.0, alpha: 1.0)
        self.pickerView.textColor = UIColor.whiteColor()
        self.pickerView.interitemSpacing = 17.0
        self.pickerView.viewDepth = 1000.0
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        
        self.timePicker.font = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.timePicker.textColor = UIColor(red: 0/256, green: 0/256, blue: 0/256, alpha: 0.5)
        self.timePicker.highlightedFont = UIFont(name: "AvenirNext-Medium", size: 17)!
        self.timePicker.highlightedTextColor = UIColor(red: 55.0/256.0, green: 198.0/256.0, blue: 144.0/256.0, alpha: 1.0)
        self.timePicker.textColor = UIColor.whiteColor()
        self.timePicker.interitemSpacing = 17.0
        self.timePicker.viewDepth = 1000.0
        self.timePicker.pickerViewStyle = .Wheel
        self.timePicker.maskDisabled = false
        self.timePicker.reloadData()
        
        nameLabel.text = tourName
        costLabel.text = tourCost
        sumLabel.text = tourSum
       // reviewNumLabel.text = "(\(reviewsNum))"
        self.languages = tourLang
        self.time = tourTimes
        
        self.selectedLanguage = "None"
        self.selectedTime = "None"
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let avgRating = avgRating {
            println ("THIS IS \(avgRating)")
            
            if (avgRating == 0){
                reviewImage.image = UIImage(named : "1stars")
            }
            else if (avgRating == 1){
                reviewImage.image = UIImage(named : "1stars")
            }
            else if (avgRating == 2){
                reviewImage.image = UIImage(named : "2stars")
            }
            else if (avgRating == 3){
                reviewImage.image = UIImage(named : "3stars")
            }
            else if (avgRating == 4){
                reviewImage.image = UIImage(named : "4stars")
            }
            else{
                reviewImage.image = UIImage(named : "5stars")
                }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (selectedTime == "1"){
            var number = 2*40
            var answer = String(number)
            self.totalLabel.text = answer
        }
        
    }
    
    //MARK: all about the pop up date picker and the TextField Delegate
    func resign() {
        
    //    dateLabel.resignFirstResponder()
    }
   /* func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
    
        if (textField === dateLabel) {
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate : NSDate? = formatter.dateFromString(dateLabel.text)
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
                
            }
            
            popDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
        }
        else {
            return true
        }
    } */
    
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
        println("Your language \(selectedLanguage)")
        }
        else{
            self.selectedTime = self.time[item]
            println("Your time \(selectedTime)")
            if (selectedTime == "1"){
                var number = 1*1
                var answer = "$\(number).00"
                self.totalLabel.text = answer
            }
            else if (selectedTime == "12"){
                var number = 12*1
                var answer = "$\(number).00"
                self.totalLabel.text = answer
            }
            else if (selectedTime == "40"){
                var number = 40*1
                var answer = "$\(number).00"
                self.totalLabel.text = answer
            }
            else if (selectedTime == "100") {
                var number = 100*1
                var answer = "$\(number).00"
                self.totalLabel.text = answer
            }
        }
    }
    
    
    @IBAction func requestButtonPressed(sender: UIButton) {
            if (self.selectedLanguage == "None" || self.selectedTime == "None"){
                //GIVES AN ERROR MESSAGE
                var alert = UIAlertController(title: "Incomplete Request!", message: "Please select a payment type and number of trees to be planted.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                    //...
                }
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{ //User has selected time, date and language
                sender.backgroundColor = UIColor.grayColor()
                var request = PFObject(className: "RequestTour")
                request["requestedTime"] = self.selectedTime
                if(selectedTime == "1"){
                    var trees = PFUser.currentUser()!["treesPlanted"] as! Int + 1
                    PFUser.currentUser()!["treesPlanted"] = trees
                    var points = PFUser.currentUser()!["pointsEarned"] as! Int + 10
                    PFUser.currentUser()!["pointsEarned"] = points
                    PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
                }
                else if (selectedTime == "12"){
                    var trees = PFUser.currentUser()!["treesPlanted"] as! Int + 12
                    PFUser.currentUser()!["treesPlanted"] = trees
                    var points = PFUser.currentUser()!["pointsEarned"] as! Int + 120
                    PFUser.currentUser()!["pointsEarned"] = points
                    PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
                }
                else if (selectedTime == "40"){
                    var trees = PFUser.currentUser()!["treesPlanted"] as! Int + 40
                    PFUser.currentUser()!["treesPlanted"] = trees
                    var points = PFUser.currentUser()!["pointsEarned"] as! Int + 400
                    PFUser.currentUser()!["pointsEarned"] = points
                    PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
                }
                else if (selectedTime == "100"){
                    var trees = PFUser.currentUser()!["treesPlanted"] as! Int + 100
                    PFUser.currentUser()!["treesPlanted"] = trees
                    var points = PFUser.currentUser()!["pointsEarned"] as! Int + 1000
                    PFUser.currentUser()!["pointsEarned"] = points
                    PFUser.currentUser()?.saveInBackgroundWithBlock(nil)
                }
                request["requestedLang"] = self.selectedLanguage
                request["fromUser"] = PFUser.currentUser()
                request["isApproved"] = false
                request["toTour"] = self.selectedTour
                request["toUser"] = self.createdBy
                request["isRejected"] = false
                request["isCancelled"] = false
                request["requestedDate"] = "Trees Planted"
                // setting global variable requestSubmitted to true for the query to be done.
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.requestSubmitted = true
                
                request.saveInBackgroundWithBlock{(success: Bool, error: NSError?) -> Void in
                    if (success){
                        var alert = UIAlertController(title: "Donation Sent!", message: "Check the DashBoard for your earned points.", preferredStyle: .Alert)
                        let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                            //...
                            self.navigationController?.popToRootViewControllerAnimated(true)
                        }
                        alert.addAction(OKAction)
                        
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    else{
                        println("Boy kya scene")
                    }
                }
            }
        }
        
    }
    


 


