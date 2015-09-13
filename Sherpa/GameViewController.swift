//
//  GameViewController.swift
//  Shapes-Game
//
//  Created by John Yang on 9/12/15.
//  Copyright (c) 2015 John Yang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //Correct Answers
    @IBOutlet weak var startGame: UIButton! //Start the Game
    @IBOutlet weak var yellowDot: UIButton! //Step 1
    @IBOutlet weak var blueDot: UIButton! // Step 2
    @IBOutlet weak var greenStar: UIButton! // Step 3
    @IBOutlet weak var choice3: UIButton! //Step 4
    @IBOutlet weak var dummyChoice1: UIImageView!
    @IBOutlet weak var dummyChoice2: UIImageView!
    
    //Title Background
    @IBOutlet weak var backgroundView: UIView!
    
    //Title Command
    @IBOutlet weak var command: UILabel!
    
    var dummyShapes:[String] = ["bluepolygon", "bluestar", "bluetriangle", "greencircle", "greentriangle", "redOval", "redpolygon", "redstar", "redtriangle"]
    
    //Step 4
    @IBOutlet weak var wrongAnswerOne: UIButton!
    @IBOutlet weak var sallyAnneImage: UIImageView!
    @IBOutlet weak var wrongAnswerTwo: UIButton!
    
    //Time
    var times: [Double] = [] //In SECONDS
    var startTime: NSTimeInterval! //In MILLISECONDS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        command.font = UIFont(name: "AvenirNext-Medium", size: 17)
        
        startGame.hidden = false
        
        backgroundView.hidden = true
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.backgroundColor = UIColor(red: 230, green: 42, blue: 76, alpha: 0.5).CGColor
        
        command.text = "Level 1: Click the Yellow Circle"
        command.hidden = true
        self.disableButton(yellowDot)
        self.disableButton(blueDot)
        self.disableButton(greenStar)
        
        choice3.setTitle("The Box", forState: .Normal)
        sallyAnneImage.hidden = true
        wrongAnswerOne.setTitle("The Marble", forState: .Normal)
        wrongAnswerTwo.setTitle("The Basket", forState: .Normal)
        self.disableButton(wrongAnswerOne)
        self.disableButton(wrongAnswerTwo)
        self.disableButton(choice3)
    }
    
    /*.animateWithDuration(0.5, delay: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: {self.uiImageView.alpha = 0.0}, completion: nil)*/
    
    //ADDING SWIFT SPINNER
    func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func demoSpinner() {
        
        SwiftSpinner.showWithDelay(2.0, title: "It's taking longer than expected")
        
        delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Connecting \nto MUSE...").addTapHandler({
                println("tapped")
                SwiftSpinner.hide()
                }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
        })
        
        delay(seconds: 4.0, completion: {
            SwiftSpinner.show("Authenticating MUSE connection")
        })
        
        delay(seconds: 8.0, completion: {
            SwiftSpinner.show("Failed to connect, waiting...", animated: false)
        })
        
        delay(seconds: 13.0, completion: {
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            SwiftSpinner.show("Retrying to authenticate")
        })
        
        delay(seconds: 18.0, completion: {
            SwiftSpinner.show("Connecting...")
        })
        
        delay(seconds: 21.0, completion: {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.show("MUSE Connected!", animated: false)
        })
        
        delay(seconds: 22.0, completion: {
            SwiftSpinner.hide()
        })

    }
    
    //END OF SWIFT SPINNER
    
    //Game STARTS - One Dot
    @IBAction func startGameClicked(sender: AnyObject) {
        self.demoSpinner()
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.disableButton(startGame)
        backgroundView.hidden = false
        
        command.hidden = false
        self.enableButton(yellowDot)
        self.dummyChoice1.image = UIImage(named:
            self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
        self.dummyChoice2.image = UIImage(named: self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
    }
    
    //Round 1 COMPLETED, Round 2 STARTS - Two Dots
    @IBAction func YellowDotClicked(sender: AnyObject) {
        times.append(self.calculateTime(startTime))
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.disableButton(yellowDot)
        self.enableButton(blueDot)
        self.dummyChoice1.image = UIImage(named: self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
        self.dummyChoice2.image = UIImage(named: self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
        command.text = "Level 2: Click the Blue Circle"
    }
    
    //Round 2 COMPLETED, Round 3 STARTS - Stars
    @IBAction func blueDotClocked(sender: AnyObject) {
        times.append(self.calculateTime(startTime))
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.disableButton(blueDot)
        self.enableButton(greenStar)
        self.dummyChoice1.image = UIImage(named: self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
        self.dummyChoice2.image = UIImage(named: self.dummyShapes[Int(arc4random_uniform(UInt32(self.dummyShapes.count)))])
        command.text = "Level 3: Click the Green Star"
    }
    
    
    //Round 3 COMPLETED, Round 4 STARTS - Sally Anne Question
    @IBAction func greenStarClicked(sender: AnyObject) {
        times.append(self.calculateTime(startTime))
        startTime = NSDate.timeIntervalSinceReferenceDate()
        self.disableButton(greenStar)
        self.dummyChoice1.hidden = true;
        self.dummyChoice2.hidden = true;
        
        command.text = "Level 4: Read the following question"
        sallyAnneImage.hidden = false
        self.enableButton(choice3)
        self.enableButton(wrongAnswerOne)
        self.enableButton(wrongAnswerTwo)
    }
    
    //Round 4 COMPLETED
    
}

extension GameViewController {
    func disableButton(button: UIControl!) {
        button.hidden = true
        button.enabled = false
    }
    
    func enableButton(button: UIControl!) {
        button.hidden = false
        button.enabled = true
    }
    
    func hideViews(views: [UIView]) {
        for var i = 0; i < views.count; i++ {
            views[i].hidden = true
        }
    }
    
    func showViews(views: [UIButton]) {
        for var i = 0; i < views.count; i++ {
            views[i].hidden = false
        }
    }
    
    func calculateTime(time: NSTimeInterval) -> Double {
        var endTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime = endTime - time
        return Double(round(1000*elapsedTime)/1000); //Double(round(1000*x)/1000)
    }
}