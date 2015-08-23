//
//  CallViewController.swift
//  Sherpa
//
//  Created by Arun Rawlani on 23/8/15.
//  Copyright (c) 2015 Arun Rawlani. All rights reserved.
//

import UIKit



class CallViewController: UIViewController, SINCallDelegate {
  
  @IBOutlet weak var remoteUsername: UILabel!
  @IBOutlet weak var callStateLabel: UILabel!
  @IBOutlet weak var callPicture: UIImageView!
  
  @IBOutlet weak var answerButton: UIButton!
  @IBOutlet weak var declineButton: UIButton!
  @IBOutlet weak var endCallButton: UIButton!
  
  var call: SINCall?
  
    override func viewDidLoad() {
      super.viewDidLoad()
  
      let dir = call!.direction
      if dir == SINCallDirection.Incoming {
        setCallStatusText("")
        showButtons(false)
        playRingtone("incoming.wav")
        callDidProgress(call!)

      } else {
        playRingtone("incoming.wav")
        setCallStatusText("Calling")
        showButtons(false)
      }
  }

  @IBAction func answer(sender: AnyObject) {
    stopRingtone()
    call!.answer()
  }
  
  @IBAction func decline(sender: AnyObject) {
    call!.hangup()
    stopRingtone()
    
  performSegueWithIdentifier("endcall", sender: self)
  
}
  
  @IBAction func endCall(sender: AnyObject) {
    call!.hangup()
    stopRingtone()
    self.navigationController?.popViewControllerAnimated(true)
    

    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    remoteUsername.text = call!.remoteUserId
  }
  
  func callDidProgress(call: SINCall) {
    setCallStatusText("Ringing")
    playRingtone("incoming.wav")
  }
  
  func callDidEstablish(call: SINCall) {
    stopRingtone()
    setCallStatusText("Established")
    showButtons(false)
  }
    
 //   func callDidEnd(call: SINCall) {
 //   stopRingtone()
 //   performSegueWithIdentifier("endcall", sender: self)
 // }
  
  func playRingtone(file: String) {
    getAudioController().startPlayingSoundFile(getPathForSound(file), loop: true)
  }
  
  func stopRingtone() {
    getAudioController().stopPlayingSoundFile()
  }
  
  func getAudioController() -> SINAudioController {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).client!.audioController()
  }
  
  func getPathForSound(soundName: String) -> String {
    return NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent(soundName)
  }
  
  func setCallStatusText(text: String) {
    callStateLabel.text = text;
  }
  
  func showButtons(show: Bool) {
    if show {
      answerButton.hidden = false
      declineButton.hidden = false
      endCallButton.hidden = true
    } else {
      answerButton.hidden = true
      declineButton.hidden = true
      endCallButton.hidden = false
    }
  }
}