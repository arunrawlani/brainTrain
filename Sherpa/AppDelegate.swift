//
//  AppDelegate.swift
//  Sherpa
//
//  Created by Akhil Nadendla on 7/18/15.
//  Copyright (c) 2015 Akhil Nadendla. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SINClientDelegate {

    var window: UIWindow?
    var client: SINClient?
    var splash: UIImageView?
    
    func createSinchClient(userId: String) {
        if client == nil {
            client = Sinch.clientWithApplicationKey("a2bbc056-429c-4ce2-b742-1de024cc1b76", applicationSecret: "VlPqzQgjbkKd+z5KRbDC/w==", environmentHost: "sandbox.sinch.com", userId: userId)
            
            client!.setSupportCalling(true)
            client!.setSupportActiveConnectionInBackground(true)
            
            client!.delegate = self
            
            client!.start()
            client!.startListeningOnActiveConnection()
        }
    }
    
    func clientDidStart(client: SINClient) {
        NSLog("client did start")
        println(client.userId)
    }
    
    func clientDidStop(client: SINClient) {
        NSLog("client did stop")
    }
    
    func clientDidFail(client: SINClient, error: NSError!) {
        NSLog("client did fail", error.description)
        let toast = UIAlertView(title: "Failed to start", message: error.description, delegate: nil, cancelButtonTitle: "OK")
        toast.show()
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
    application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
    UIUserNotificationType.Sound | UIUserNotificationType.Alert,
    categories: nil
    ))
        
    if launchOptions != nil {
        if launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] != nil {
            handleLocalNotification(launchOptions![UIApplicationLaunchOptionsLocalNotificationKey] as! UILocalNotification)
        }
    }
    
        
    UINavigationBar.appearance().barTintColor = UIColor(red: 229/255.0, green: 147/255.0, blue: 52/255.0, alpha: 100.0)
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    UINavigationBar.appearance().translucent = false
    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    
    FBSDKLoginManager().logOut()

    return true
    }
    
    func handleLocalNotification(notification: UILocalNotification) {
        if client != nil {
            let result: SINNotificationResult = client!.relayLocalNotification(notification)
            if result.isCall() && (result.callResult().isTimedOut) {
                let msg = "Missed call from " + result.callResult().remoteUserId
                let alert = UIAlertView()
                alert.title = "Missed call"
                alert.message = msg
                alert.show()
            }
        }
    }
    
    func dismissSplashViewIfNecessary() {
        if self.splash != nil {
            window!.bringSubviewToFront(splash!)
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.TransitionNone,
                animations: {
                    () -> Void in
                    self.splash!.alpha = 0.0
                },
                completion: {
                    (Bool) -> Void in
                    self.splash!.removeFromSuperview()
            })
        }
    }
    
    func addSplashView() {
        self.splash = UIImageView(frame: CGRectMake(0, 0, 320, 480))
        splash!.image = UIImage(named: "Default")
        splash!.tag = 4321
        splash!.alpha = 1.0
        
        self.window!.addSubview(splash!)
    }

}

