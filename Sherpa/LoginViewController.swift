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
import ParseUI


class LoginViewController: UIViewController {
  
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var window: UIWindow?
    
    var currentUser: PFUser?
    var startViewController: UIViewController?
    
  
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.actInd.center = self.view.center
    
    self.actInd.hidesWhenStopped = true
    
    self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
    
    view.addSubview(self.actInd)
    
    //this causes our activity indicator to be in the center of the view with colour White
    
    if currentUser != nil {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        startViewController = storyboard.instantiateViewControllerWithIdentifier("TabBarController") as? UIViewController
    } else {
        println("No user is logged in. \n Login or signup")
    }
    
    
  }
    
    //MARK:Actions
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var username = self.usernameTF.text
        var password = self.passwordTF.text
        
        
        if (count(username.utf16) < 3 || count(password.utf16) < 3){
            
            var alert = UIAlertController(title: "Invalid", message: "Username and Password are too short.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)

          }
        
        else
        {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: {(user, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if ((user) != nil){
                    
                    
                   var alert = UIAlertController(title: "Success", message: "Logged In.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //...
                    }
                    alert.addAction(OKAction)
                   // self.presentViewController(alert, animated: true, completion: nil)
                    self.performSegueWithIdentifier("testSegue", sender: nil)
                   // AppDelegate().showMainScreen()
 
            }

            else
            {
                var alert = UIAlertController(title: "Error", message: "Please enter valid login parameters.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //...
                }
                alert.addAction(OKAction)
                self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
}
    
}
  /*
// func loginAction() {
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
*/
  
 
    
    
    
    
    
/*
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

  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
*/