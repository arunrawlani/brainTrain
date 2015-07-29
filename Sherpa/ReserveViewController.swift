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
    let time = ["9:30", "10:30", "11:30", "12:30", "1:30", "2:30", "3:30"]
    
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var timePicker: AKPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        
        self.pickerView.tag = 1
        self.timePicker.tag = 2

        
        self.pickerView.font = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.pickerView.highlightedFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.pickerView.highlightedTextColor = UIColor(red: 229.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 1.0)
        self.pickerView.textColor = UIColor.whiteColor()
        self.pickerView.interitemSpacing = 17.0
        self.pickerView.viewDepth = 1000.0
        self.pickerView.pickerViewStyle = .Wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        
        self.timePicker.font = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.timePicker.highlightedFont = UIFont(name: "AvenirNext-Regular", size: 17)!
        self.timePicker.highlightedTextColor = UIColor(red: 229.0/256.0, green: 147.0/256.0, blue: 52.0/256.0, alpha: 0.5)
        self.timePicker.textColor = UIColor.whiteColor()
        self.timePicker.interitemSpacing = 17.0
        self.timePicker.viewDepth = 1000.0
        self.timePicker.pickerViewStyle = .Wheel
        self.timePicker.maskDisabled = false
        self.timePicker.reloadData()
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
        println("Your favorite city is \(self.languages[item])")
    }
}
