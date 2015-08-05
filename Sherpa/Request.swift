//
//  Request.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 8/4/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import Parse

class Request:PFObject, PFSubclassing{
    
    @NSManaged var isApproved: Boolean
    @NSManaged var fromUser: PFUser?
    @NSManaged var toTour: Tour?
    @NSManaged var requestedTime: String
    @NSManaged var requestedLang: String
    @NSManaged var toUser: PFUser?
    @NSManaged var requestedDate: String
    
    //MARK : PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "RequestTour"
    }
    
    override init(){
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
