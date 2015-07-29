//
//  ReserveViewController.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 7/29/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import Foundation
import AKPickerView_Swift

class ReserveViewController: UIViewController, AKPickerViewDataSource, AKPickerViewDelegate {
    
    let languages = ["Madarin", "Chinese", "Hindi", "Urdu", "Saitama", "Chiba", "Hyogo", "Hokkaido", "Fukuoka", "Shizuoka"]
    
    @IBOutlet weak var pickerView: AKPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.pickerView.font = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.pickerView.highlightedFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.pickerView.highlightedTextColor = UIColor(red: 229.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 1.0)
        self.pickerView.textColor = UIColor.whiteColor()
        self.pickerView.interitemSpacing = 17.0
        self.pickerView.viewDepth = 1000.0
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return self.languages.count
    }
    
    /*
    
    Image Support
    -------------
    Please comment '-pickerView:titleForItem:' entirely and
    uncomment '-pickerView:imageForItem:' to see how it works.
    
    */
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.languages[item]
    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.languages[item])!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        println("Your favorite city is \(self.languages[item])")
    }
}
