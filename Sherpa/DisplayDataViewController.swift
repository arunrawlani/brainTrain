//
//  DisplayDataViewController.swift
//  autism
//
//  Created by Praynaa Rawlani on 9/13/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit

class DisplayDataViewController: UIViewController {

    @IBOutlet weak var timeTakenValue: UILabel!
    @IBOutlet weak var EEGLabelValue: UILabel!
    
    @IBOutlet weak var currentVal: UILabel!
    @IBOutlet weak var targetVal: UILabel!
    
    var time:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeTakenValue.text = "\(time)s"
        // Do any additional setup after loading the view.
        
        var eegVal:Int = Int(arc4random_uniform(UInt32(200))) + 600
        EEGLabelValue.text = "\(eegVal)µV"
        
        var cVal:Int = Int(arc4random_uniform(UInt32(15))) + 80
        var tVal:Int = Int(arc4random_uniform(UInt32(15))) + 105
        currentVal.text = "\(cVal)"
        targetVal.text = "\(tVal)"
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
