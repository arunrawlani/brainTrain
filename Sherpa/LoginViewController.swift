//
//  LoginViewController.swift
//  Sherpa
//
//  Created by Derek Argueta on 7/19/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Parse


class LoginViewController: UIViewController {
  
  @IBOutlet weak var usernameTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  /*
@IBAction func loginAction() {
    let username = usernameTF.text
    let password = passwordTF.text
    
    while (username == "") {
        println("Please enter a username")
        break
    }
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    appDelegate.createSinchClient(username)
    
    //change loggedIn back to let. ALSO REMOVE THE // FROM THE FOLLOWING LINE
    //var loggedIn = Netwerker.login(username, password: password)
   
    //MAKING WIERD CHANGES POST-HACKATHON. CHECK
    let loggedIn = true
    
    if loggedIn {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let vc = storyboard.instantiateViewControllerWithIdentifier("yoyo") as! UITabBarController
      self.presentViewController(vc, animated: true, completion: nil)
    } else {
      UIAlertView(title: "Error", message: "bad login", delegate: nil, cancelButtonTitle: "Ok").show()
    }
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.view.endEditing(true)
  }
  
 
    
    
    
    
    
    
    @IBAction func facebookLogin() {
    println("#fuckitshipit")
//    let fbLogin = FBSDKLoginManager()
//    fbLogin.logInWithReadPermissions(["email"], handler: { (result, error) -> Void in
//      
//      let res: FBSDKLoginManagerLoginResult = result as FBSDKLoginManagerLoginResult
//      let err: NSError? = error as NSError?
//      
//      if err != nil {
//          // process error
//        println("error?")
//      } else if res.isCancelled {
//        // handle cancellations
//        println("cancellation?")
//        
//        println(res.token)
//        println(FBSDKAccessToken.currentAccessToken())
//        
//        // rock n roll
////        if (FBSDKAccessToken.currentAccessToken() != nil) {
//          FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({(connection, result, error) -> Void in
//            let err: NSError? = error as NSError?
//            let res: AnyObject? = result as AnyObject?
//            if err != nil {
//              println("fetched user? \(res)")
//            }
//          })
////        }
//        
//      } else {
//        if res.grantedPermissions.contains("email") {
//          
//          println(res.token)
//          println(FBSDKAccessToken.currentAccessToken())
//          
//          // rock n roll
//          if (FBSDKAccessToken.currentAccessToken() != nil) {
//            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({(connection, result, error) -> Void in
//              let err: NSError? = error as NSError?
//              let res: AnyObject? = result as AnyObject?
//              if err != nil {
//                println("fetched user? \(res)")
//              }
//            })
//          }
//        }
//      }
//      
//      println("wut the wut")
//    })
  }
  
  @IBAction func twitterLogin() {
    println("#fuckitshipit")
  }
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
 */
}