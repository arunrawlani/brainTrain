//
//  Tour.swift
//  Sherpa
//
//  Created by Derek Argueta on 7/18/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import UIKit

class Tour: NSObject {
  
  var guid: String?
  var title: String
  var languages: [String]
  var desc: String
  var reviews: [Review]
  
  init(title: String, languages: [String], description: String) {
    
    self.title = title
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
  }
}
