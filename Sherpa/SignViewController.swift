//
//  SignViewController.swift
//  Sherpa
//
//  Created by Praynaa Rawlani on 7/22/15.
//  Copyright (c) 2015 Derek Argueta. All rights reserved.
//

import Foundation
import UIKit
import Parse


class SignViewController: UIViewController{
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        
        
        self.actInd.hidesWhenStopped = true
        
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        
        view.addSubview(self.actInd)
        
        //this causes our activity indicator to be in the center of the view with colour White
    }
    
    //MARK: Actions
    @IBAction func signUpAction(sender: AnyObject) {
        
        var firstName = self.firstNameTF.text
        var lastName = self.lastNameTF.text
        var username = self.usernameTF.text
        var password = self.passwordTF.text
        var email = self.emailTF.text
        
        
        if (count(firstName.utf16) < 1 || count(lastName.utf16) < 1){
            var alert = UIAlertController(title: "Invalid", message: "Enter enter a valid First and Last name.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else if (count(username.utf16) < 3 || count(password.utf16) < 3){
            
            var alert = UIAlertController(title: "Invalid", message: "Username and Password are too short.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else if (count(email.utf16) < 10) {
            
            var alert = UIAlertController(title: "Invalid", message: "Please enter a valid email", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else{
            
            self.actInd.startAnimating()
            
            var newUser = PFUser()
            
            newUser["firstName"] = firstName
            newUser["lastName"] = lastName
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (suceed, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if ((error) != nil) {
                    var alert = UIAlertController(title: "Error", message: "Oops! Username \(username) is already taken. Enter a different username.", preferredStyle: .Alert)
                    let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                        //...
                    }
                    alert.addAction(OKAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                else
                {
                    var alert = UIAlertController(title: "Success", message: "Signed Up", preferredStyle: .Alert)
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
