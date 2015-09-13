//
//  ResultsViewController.swift
//  autism
//
//  Created by Praynaa Rawlani on 9/12/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var alphaGraph : GraphEEGView!
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
