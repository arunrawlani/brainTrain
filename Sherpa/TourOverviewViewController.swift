//  TourOverviewViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import Darwin
import AKPickerView_Swift

class TourOverviewViewController: UIViewController, SINCallClientDelegate, AKPickerViewDataSource, AKPickerViewDelegate {
    
    
    
    

    @IBOutlet weak var pickerView: AKPickerView!

 
    @IBOutlet var TourNameLabel: UILabel!
    @IBOutlet var tourCityImageview: UIImageView!
    
    @IBOutlet weak var callButton: UIBarButtonItem!
    @IBOutlet var TourPrice: UILabel!
    @IBOutlet var starRatingImageView: UIImageView!
    var tourname: String = ""
    var ImageName: String = ""
    var tourPriceamt: String = ""
    
    @IBOutlet var reserveButton: UIButton!
    var thisIsFucked: Int = 1
    
    @IBAction func reserveButtonPressed(sender: AnyObject) {
        println(thisIsFucked)
        if thisIsFucked == 1 {
            reserveButton.setImage(UIImage(named: "PaymentMethod"), forState: .Normal)
        }
        else {
            performSegueWithIdentifier("purchased", sender: self)
        }
        thisIsFucked++
    }
    @IBAction func viewTimeline(sender: AnyObject) {
        performSegueWithIdentifier("goToTimeline", sender: self)
    }
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    
    var but1ON: Bool = false
    var but2ON: Bool = false
    var but3ON: Bool = false
    var but4ON: Bool = false
    var but5ON: Bool = false
    var but6ON: Bool = false
    var but7ON: Bool = false
    
    @IBAction func ButtonSelected(sender: AnyObject) {
        println(sender.tag)
        switch(sender.tag) {
        case 1:
            if but1ON == false {
                but1ON = true
                button1.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but1ON = false
                button1.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 2:
            if but2ON == false {
                but2ON = true
                button2.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but2ON = false
                button2.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 3:
            if but3ON == false {
                but3ON = true
                button3.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but3ON = false
                button3.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 4:
            if but4ON == false {
                but4ON = true
                button4.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but4ON = false
                button4.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 5:
            if but5ON == false {
                but5ON = true
                button5.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but5ON = false
                button5.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 6:
            if but6ON == false {
                but6ON = true
                button6.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but6ON = false
                button6.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        case 7:
            if but7ON == false {
                but7ON = true
                button7.setBackgroundImage(UIImage(named: "TourOverviewButtonBGSelected"), forState: .Normal)
            }
            else {
                but7ON = false
                button7.setBackgroundImage(UIImage(named: "TourOverviewButtonBG"), forState: .Normal)
            }
            break
        default:
            break
        }
    }
    
    
    @IBAction func call(sender: AnyObject) {
        
        if client().isStarted() {
            var call: SINCall = client().callClient().callUserWithId("test@email.com")
            performSegueWithIdentifier("goToCall", sender: call)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "goToCall" {
            var callViewController: CallViewController = segue.destinationViewController as! CallViewController;
            var call = sender as! SINCall
            callViewController.call = call
            call.delegate = callViewController
        }
        else if segue.identifier == "goToTimeline" {
            var tvc: TimelineViewController = segue.destinationViewController as! TimelineViewController
            tvc.whichTimeline = ImageName
        }
    }
    
    let titles = ["Tokyo", "Kanagawa", "Osaka", "Aichi", "Saitama", "Chiba", "Hyogo", "Hokkaido", "Fukuoka", "Shizuoka"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        
        self.pickerView.font = UIFont(name: "Avenir", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "AvenirNext-Bold", size: 20)!
        self.pickerView.highlightedTextColor = UIColor(red: 229, green: 147, blue: 52, alpha: 1)
        self.pickerView.interitemSpacing = 20.0
        self.pickerView.viewDepth = 1000.0
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
    
        client().callClient().delegate = self
        
        TourNameLabel.text = tourname
        tourCityImageview.image = UIImage(named: ImageName)
        var myNSString = tourPriceamt as NSString
        //Commented out is the one we used at the hackathon 
        //myNSString = myNSString.substringWithRange(NSRange(location: 0, length: myNSString.length-1))
        myNSString = myNSString.substringWithRange(NSRange(location: 0, length: myNSString.length))
        
        tourPriceamt = String(myNSString)
        
        TourPrice.text = tourPriceamt
       
        let diceRoll = Int(arc4random_uniform(3))
        if diceRoll == 0 {
            starRatingImageView.image = UIImage(named: "3stars")
        }
        else if diceRoll == 1 {
            starRatingImageView.image = UIImage(named: "4stars")
        }
        else{
            starRatingImageView.image = UIImage(named: "5stars")
        }
        thisIsFucked = 1
        // Do any additional setup after loading the view.
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.titles.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.titles[item])!
    }
    
    func client() -> SINClient {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.client!
    }
    
    func client(client: SINCallClient!, didReceiveIncomingCall call: SINCall!) {
        println("called client(didReceiveIncomingCall)")
        performSegueWithIdentifier("goToCall", sender: call)
    }
    
    func client(client: SINCallClient!, localNotificationForIncomingCall call: SINCall!) -> SINLocalNotification! {
        let ret = SINLocalNotification()
        ret.alertAction = "Answer"
        ret.alertBody = "Incoming call from " + call.remoteUserId
        return ret;
    }
}
