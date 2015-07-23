//
//  ParseLoginHelper.swift
//  Sherpa
//
//  Created by Arun Rawlani on 7/21/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Parse
import ParseUI

typealias ParseLoginHelperCallback = (PFUser?, NSError?) -> Void

/**
This class implements the 'PFLogInViewControllerDelegate' protocol. After a successfull login
it will call the callback function and provide a 'PFUser' object.
*/
class ParseLoginHelper : NSObject, NSObjectProtocol {
    static let errorDomain = "com.makeschool.parseloginhelpererrordomain"
    static let usernameNotFoundErrorCode = 1
    static let usernameNotFoundLocalizedDescription = "Could not retrieve Facebook username"
    
    let callback: ParseLoginHelperCallback
    
    init(callback: ParseLoginHelperCallback) {
        self.callback = callback
    }
}

extension ParseLoginHelper : PFLogInViewControllerDelegate {
    
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        if (!username.isEmpty || !password.isEmpty){
            return true
        }
        else{
            return false
        }
    }
    
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        // Determine if this is a Facebook login
        let isFacebookLogin = FBSDKAccessToken.currentAccessToken() != nil
        
        if !isFacebookLogin {
            // Plain parse login, we can return user immediately
            self.callback(user, nil)
        } else {
            // if this is a Facebook login, fetch the username from Facebook
            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler {
                (connection: FBSDKGraphRequestConnection!, result: AnyObject?, error: NSError?) -> Void in
                if let error = error {
                    // Facebook Error? -> hand error to callback
                    self.callback(nil, error)
                }
                
                if let fbUsername = result?["name"] as? String {
                    // assign Facebook name to PFUser
                    user.username = fbUsername
                    // store PFUser
                    user.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        if (success) {
                            // updated username could be stored -> call success
                            self.callback(user, error)
                        } else {
                            // updating username failed -> hand error to callback
                            self.callback(nil, error)
                        }
                    })
                } else {
                    // cannot retrieve username? -> create error and hand it to callback
                    let userInfo = [NSLocalizedDescriptionKey : ParseLoginHelper.usernameNotFoundLocalizedDescription]
                    let noUsernameError = NSError(
                        domain: ParseLoginHelper.errorDomain,
                        code: ParseLoginHelper.usernameNotFoundErrorCode,
                        userInfo: userInfo
                    )
                    self.callback(nil, error)
                }
            }
        }
    }
    
    //This will override the dialog box coming on the screen when a not legit login is done
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Did fail to login")
    }
    
}

extension ParseLoginHelper : PFSignUpViewControllerDelegate {
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.callback(user, nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("User failed to sign up. Bad, weak Sparta.")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("Did dismiss Sign Up. User says Spartaaaaa.")
    }
    
}
