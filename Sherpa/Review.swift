//
//  Review.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//


import Foundation
import Parse

class Review:PFObject, PFSubclassing{
    
    
    @NSManaged var fromUser: PFUser?
    @NSManaged var toTour: Tour?
    @NSManaged var ratingGiven: Int
    @NSManaged var reviewContent: String?
    
    
    //MARK : PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "Review"
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

