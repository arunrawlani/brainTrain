//
//  Review.swift
//  Sherpa
//
//  Created by Derek Argueta on 7/18/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import UIKit

class Review: NSObject {
  
  var text: String
  var userId: String
  var rating: Double
  
  init(text: String, userId: String, rating: Double) {
    
    self.text = text
    self.userId = userId
    self.rating = rating
    
    super.init()
  }
   
}
