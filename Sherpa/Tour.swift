//
//  Tour.swift
//  Sherpa
//
//  Created by Derek Argueta on 7/18/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import UIKit
import Parse

class Tour: PFObject, PFSubclassing {
    
  @NSManaged var createdBy : PFUser?
  @NSManaged var tourName: String?
  @NSManaged var langOffered: [String]?
  @NSManaged var tourDetail: String?
  //@NSManaged var reviews: [Review]
  @NSManaged var cost: String
  @NSManaged var city : String?
  @NSManaged var guideImage: PFFile?
  @NSManaged var prefTimes: [String]?
  @NSManaged var prefDates: [String]?
  @NSManaged var tourImage: PFFile?


    //MARK : PFSubclassing Protocol

    static func parseClassName() -> String {
        return "Tour"
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
  
 /*

    init(title: String, languages: [String], description: String) {
    
    self.tourName = title
    self.languages = languages
    self.desc = description
    self.reviews = []
    
    super.init()
  }
  
  init(title: String, languages: [String], description: String, reviews: [Review]) {
    
    self.title = title
    self.languages = languages
    self.desc = description
    self.reviews = reviews
    
    super.init()
  }
  
  func dict() -> [String: AnyObject] {
    let title = self.title
    let desc = self.desc
    return [
      "title": title,
      "description": desc,
      "languages": self.languages
    ]
  } */
