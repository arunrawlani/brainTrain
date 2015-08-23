//
//  Netwerker.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit

class Netwerker: NSObject {
  
  /*
    //
  // pulls all tours from the server in a list of Tour objects
  //
  static func getAllTours() -> [Tour] {
    
    var tours: [Tour] = [Tour]()
    
    var response: NSURLResponse?
    var error: NSError?
    
    let url = NSURL(string: "http://45.79.72.155:3000/api/tours")
    
    var request = NSURLRequest(URL: url!) // Creating Http Request
    // Sending Synchronous request using NSURLConnection
    let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
      options: NSJSONReadingOptions.AllowFragments,
      error:&error)
    
    if let list: NSArray = parsedObject as? NSArray {
      for obj in list {
        if let tourDict: NSDictionary = obj as? NSDictionary {
          
          // grab the data from the response JSON
          let title: String = tourDict.objectForKey("title") as! String
          let description: String = tourDict.objectForKey("description") as! String
          let langString: String = tourDict.objectForKey("languages") as! String
          
          // convert the language list into an array
          let languages = split(langString) {$0 == " "}
          
          // construct a tour object
          var tour = Tour(title: title, languages: languages, description: description)
          tours.append(tour)
        } else {
          println("could not parse single tour into dictionary in Netwerker:getAllTours")
        }
      }
    } else {
      println("could not parse list of tours as NSArray in Netwerker:getAllTours")
    }
    
    return tours
  }
  
  //
  // makes a POST request to the server for saving a new tour
  //
  static func postTour(tour: Tour) {
    
    var request = NSMutableURLRequest(URL: NSURL(string: "http://45.79.72.155:3000/api/tours")!)
    var session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    
    var err: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(tour.dict(), options: nil, error: &err)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
      var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
      var err: NSError?
      var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
      
      // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
      if(err != nil) {
        println(err!.localizedDescription)
        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
        println("Error could not parse JSON: '\(jsonStr)'")
      } else {
        // The JSONObjectWithData constructor didn't return an error. But, we should still
        // check and make sure that json has a value using optional binding.
        if let parseJSON = json {
          // Okay, the parsedJSON is here, let's get the value for 'success' out of it
          var doc = parseJSON["document"] as? NSArray
          if let list: NSArray = doc as NSArray! {
            if let item: NSDictionary = list[0] as? NSDictionary {
              let id: String = item.objectForKey("id") as! String
              tour.createdBy = id
            }
          }
        }
        else {
          // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
          let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
          println("Error could not parse JSON: \(jsonStr)")
        }
      }
    })
    
    task.resume()
  }
  
  static func login(email: String, password: String) -> Bool {
    var response: NSURLResponse?
    var error: NSError?
    
    let url = NSURL(string: "http://45.79.72.155:3000/api/users/login")
    
    var request = NSMutableURLRequest(URL: url!) // Creating Http Request
    request.HTTPMethod = "POST"
    
    let sendDict = [
      "email": email,
      "password": password
    ]
    
    var err: NSError?
    request.HTTPBody = NSJSONSerialization.dataWithJSONObject(sendDict, options: nil, error: &err)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // Sending Synchronous request using NSURLConnection
    let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!,
      options: NSJSONReadingOptions.AllowFragments,
      error:&error)
    
    if let dict: NSDictionary = parsedObject as? NSDictionary {
      if let userId: String = dict["id"] as? String {
        NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "userId")
        return true
      }
    }
    return false
  }
    */
  
}
