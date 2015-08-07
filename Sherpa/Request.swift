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
    
    @NSManaged var isApproved: Bool
    
//    var isApprovedBool: Bool {
//        
//        get {
//            
//            if (isApproved as UInt8) == 1{
//                return true
//            }
//            
//            return false
//        }
//        set {
//            if newValue {
//                isApproved = 1
//            } else{
//                isApproved = 0
//            }
//            
//        }
//    }
    @NSManaged var fromUser: PFUser?
    @NSManaged var toTour: Tour?
    @NSManaged var requestedTime: String?
    @NSManaged var requestedLang: String?
    @NSManaged var toUser: PFUser?
    @NSManaged var requestedDate: String?

    
    //MARK : PFSubclassing Protocol
    
    static func parseClassName() -> String {
        return "RequestTour"
    }
    
    override init(){
        super.init()
        //isApprovedBool = false
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
}
