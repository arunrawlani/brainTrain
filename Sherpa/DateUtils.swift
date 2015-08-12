//
//  DateUtils.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 8/12/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation

extension NSDate {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle;
        formatter.timeStyle = .NoStyle;
        return formatter.stringFromDate(self)
    }
}