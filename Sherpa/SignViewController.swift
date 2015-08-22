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
    
    var checkState = 0
    
    @IBOutlet weak var firstNameTF: UITextField!
    
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var checkBox: UIButton!
    
 
    @IBAction func checkToggle(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Customizing tint of the text fields
        var color: UIColor = UIColor(red: 55.0/255.0, green: 198.0/255.0, blue: 144.0/255.0, alpha: 100.0)
        self.firstNameTF.tintColor = color
        self.lastNameTF.tintColor = color
        self.usernameTF.tintColor = color
        self.passwordTF.tintColor = color
        self.emailTF.tintColor = color
        
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
        var pointsEarned = 0
        var treesPlanted = 0
        
        
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
        else if (checkBox.selected == false)
        {
                var alert = UIAlertController(title: "Invalid", message: "Check the box in order to proceed", preferredStyle: .Alert)
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
            newUser["pointsEarned"] = pointsEarned
            newUser["treesPlanted"] = treesPlanted
            
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
                        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                    }
                    alert.addAction(OKAction)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
            })
        }
    }
}
