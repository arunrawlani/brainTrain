//
//  ResultsViewController.swift
//  autism
//
//  Created by Praynaa Rawlani on 9/12/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit
import PNChartSwift

class ResultsViewController: UIViewController {

    /**var alphaGraph : GraphEEGView!
    var betaGraph : GraphEEGView!
    var thetaGraph : GraphEEGView!
    var wavesTitle : UILabel!
    var timeTitle : UILabel!
    var graphOpen : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var alphaVals = [3.0, 5.0, 4.0, 7.0, 3.0];
        var betaVals = [1.0, 5.0, 7.0, 2.0, 9.0];
        var thetaVals = [5.0, 5.0, 8.0, 5.0, 6.0];
        
        
        
        alphaGraph = GraphEEGView(values: alphaVals, labels: [""], count: alphaVals.count, frame: CGRectMake(20, 50, 335, 200))
        betaGraph = GraphEEGView(values: betaVals, labels: [""], count: betaVals.count, frame: CGRectMake(20, 50, 335, 200))
        thetaGraph = GraphEEGView(values: thetaVals, labels: [""], count: thetaVals.count, frame: CGRectMake(20, 50, 335, 200))
        self.view.addSubview(alphaGraph)
        graphOpen = 0
        
        wavesTitle = UILabel(frame:CGRectMake(0, 0, 120, 20))
        wavesTitle.center = CGPointMake(alphaGraph.center.x, alphaGraph.center.y - alphaGraph.frame.height/2 - 15);
        wavesTitle.textAlignment = NSTextAlignment.Center
        wavesTitle.text = "Alpha Waves"
        wavesTitle.font = UIFont(name: "AvenirNext-Medium", size: 18)
        self.view.addSubview(wavesTitle)
        
        var swipeLeft = UISwipeGestureRecognizer(target:self, action:"toLeft")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        swipeLeft.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target:self, action:"toRight")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeRight.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(swipeRight)
        
        var timeVals = [3.0, 3.2, 3.3, 2.9, 3.6];
        let timeGraph = GraphReactTimeView(values: timeVals, labels: [""], count: timeVals.count, frame: CGRectMake(20, 300, 335, 200))
        self.view.addSubview(timeGraph);
        timeTitle = UILabel(frame:CGRectMake(0, 0, 120, 20))
        timeTitle.center = CGPointMake(timeGraph.center.x, timeGraph.center.y - timeGraph.frame.height/2 - 15);
        timeTitle.textAlignment = NSTextAlignment.Center
        timeTitle.text = "Reaction Times"
        timeTitle.font = UIFont(name: "AvenirNext-Medium", size: 17)
        self.view.addSubview(timeTitle)
    }
    
    func toRight() {
        if let x = graphOpen {
            if (x == 1) {
                betaGraph.removeFromSuperview()
                self.view.addSubview(alphaGraph)
                wavesTitle.text = "Alpha"
                graphOpen = 0;
            } else if (x == 2) {
                thetaGraph.removeFromSuperview()
                self.view.addSubview(betaGraph)
                wavesTitle.text = "Beta"
                graphOpen = 1;
            }
        }
    }
    
    func toLeft() {
        if let x = graphOpen {
            if (x == 1) {
                betaGraph.removeFromSuperview()
                self.view.addSubview(thetaGraph)
                wavesTitle.text = "Theta"
                graphOpen = 2;
            } else if (x == 0) {
                alphaGraph.removeFromSuperview()
                self.view.addSubview(betaGraph)
                wavesTitle.text = "Beta"
                graphOpen = 1;
            }
        }
    }*/
    
    @IBOutlet weak var riskButton: UIButton!
    @IBOutlet weak var riskResult: UILabel!
    override func viewDidLoad() {
        riskResult.hidden = true
        let eegData = LineGraph(frame: CGRectMake(20, -80, 330, 200))
        self.view.addSubview(eegData)
        let reactionTimeData = BarGraph(frame:CGRectMake(20, 170, 330, 200))
        self.view.addSubview(reactionTimeData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func riskPressed(sender: AnyObject) {
        
        riskButton.hidden = true
        self.demoSpinner()
    }
    
    func delay(#seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func demoSpinner() {
        
        SwiftSpinner.showWithDelay(2.0, title: "It's taking longer than expected")
        
        delay(seconds: 0.0, completion: {
            SwiftSpinner.show("Computing autism risk")
        })
        
        delay(seconds: 1.0, completion: {
            SwiftSpinner.show("Fetching session data")
        })
        
        delay(seconds: 2.0, completion: {
            SwiftSpinner.show("Analyzing trends", animated: false)
        })
        
        delay(seconds: 3.0, completion: {
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            SwiftSpinner.show("Computed")
        })
        
        delay(seconds: 4.0, completion: {
            SwiftSpinner.hide()
            self.riskResult.hidden = false
        })
        
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
