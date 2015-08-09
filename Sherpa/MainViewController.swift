//
//  MainViewController.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 8/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation

class MainViewController: UIViewController{
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}