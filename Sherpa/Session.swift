//
//  Session.swift
//  autism
//
//  Created by Praynaa Rawlani on 9/12/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import Parse

class Session:PFObject, PFSubclassing{
    
    
    @NSManaged var brainValue: String?
    @NSManaged var levelDescription: String?
    @NSManaged var reactionTime: String?
    
    
    //MARK : PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "Session"
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
