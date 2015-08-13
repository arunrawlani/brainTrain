//
//  ReviewViewController.swift
//  Rating Demo
//
//  Created by Arun Rawlani
//  Copyright (c) Arun Rawlani. All rights reserved.
//

import UIKit
import Parse

class ReviewViewController: UIViewController, FloatRatingViewDelegate, UITextViewDelegate {
    
    @IBOutlet var floatRatingView: FloatRatingView!
    @IBOutlet weak var reviewContent: UITextView!
    @IBOutlet weak var postButton: UIButton!
    var enteredText: Bool = false
    var reviewedTour : Tour?

    let PLACEHOLDER_TEXT = "Example: The tour has been life defining. There was expectional hardwork put into it and I would torally recommend this to a friend. Awesome job!"
    
    var finalRating: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customizing the tint of the review content 
        var color: UIColor = UIColor(red: 229/255.0, green: 147/255.0, blue: 52/255.0, alpha: 100.0)
        self.reviewContent.tintColor = color
        
        
        /** Note: With the exception of contentMode, all of these
        properties can be set directly in Interface builder **/
        
        // Required float rating view params
        self.floatRatingView.emptyImage = UIImage(named: "StarEmpty")
        self.floatRatingView.fullImage = UIImage(named: "StarFull")
        // Optional params
        self.floatRatingView.delegate = self
        self.floatRatingView.contentMode = UIViewContentMode.ScaleAspectFit
        self.floatRatingView.maxRating = 5
        self.floatRatingView.minRating = 1
        self.floatRatingView.rating = 3
        self.finalRating = Int(self.floatRatingView.rating)
        self.floatRatingView.editable = true
        self.floatRatingView.halfRatings = false
        self.floatRatingView.floatRatings = false
        
        
        // Labels init
        var liveText = NSString(format: "%.2f", self.floatRatingView.rating) as String
        println("Live:\(liveText)")
        var updatedText = NSString(format: "%.2f", self.floatRatingView.rating) as String
        println("Updated load:\(updatedText)")
        
        applyPlaceholderStyle(reviewContent!, placeholderText: PLACEHOLDER_TEXT)
        
        reviewContent.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reviewSubmitted(sender: AnyObject) {
        if (!self.enteredText){
            //wrong
            println("Enter something")
            var alert = UIAlertController(title: "Incomplete", message: "Oops. Please leave a comment about your experience.", preferredStyle: .Alert)
            let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                //...
            }
            alert.addAction(OKAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
        var newReview = Review()
        newReview.fromUser = PFUser.currentUser()!
        //get the tour thing from last class
        newReview.ratingGiven = self.finalRating
        newReview.reviewContent = self.reviewContent.text
        newReview.toTour = self.reviewedTour
        newReview.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("The object has been saved.")
                
                var alert = UIAlertController(title: "Success!", message: "Your review has been submitted.", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default){ (action) in
                    //...
                    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
                }
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion: nil)

                
                //logic to calculate the review average
                var newNumber = self.reviewedTour!.reviewsNum + 1
                var total = self.reviewedTour!.cumulativeRating + self.finalRating
                var avg: Double = Double(total) / Double(newNumber)
                self.reviewedTour?.avgRating = Int(avg)
                self.reviewedTour?.reviewsNum = newNumber
                self.reviewedTour?.cumulativeRating = total
               
            } else {
                println("There was a problem, check error.description for this")
            }
            self.reviewedTour?.saveInBackgroundWithBlock(nil)
        }
      }
    }
    @IBAction func ratingTypeChanged(sender: UISegmentedControl) {
        self.floatRatingView.halfRatings = sender.selectedSegmentIndex==1
        self.floatRatingView.floatRatings = sender.selectedSegmentIndex==2
    }
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(ratingView: FloatRatingView, isUpdating rating:Float) {
        var liveText = NSString(format: "%.2f", self.floatRatingView.rating) as String
        println("Live:\(liveText)")
    }
    
    func floatRatingView(ratingView: FloatRatingView, didUpdate rating: Float) {
        var updatedText = NSString(format: "%.2f", self.floatRatingView.rating) as String
        println("Updated inside:\(updatedText)")
        self.finalRating = Int(floatRatingView.rating)
    }
    
    // MARK: helper functions
    
    func applyPlaceholderStyle(aTextview: UITextView, placeholderText: String)
    {
        // make it look (initially) like a placeholder
        aTextview.textColor = UIColor.lightGrayColor()
        aTextview.font = UIFont(name: "AvenirNext-Regular", size: 14)
        aTextview.text = placeholderText
    }
    
    func applyNonPlaceholderStyle(aTextview: UITextView)
    {
        // make it look like normal text instead of a placeholder
        aTextview.textColor = UIColor.whiteColor()
        aTextview.font = UIFont(name: "AvenirNext-Regular", size: 14)
        aTextview.alpha = 1.0
    }
    
    func moveCursorToStart(aTextView: UITextView)
    {
        dispatch_async(dispatch_get_main_queue(), {
            aTextView.selectedRange = NSMakeRange(0, 0);
        })
    }
    
    // MARK: UITextViewDelegate
    
    func textViewShouldBeginEditing(aTextView: UITextView) -> Bool
    {
        if aTextView == reviewContent && aTextView.text == PLACEHOLDER_TEXT
        {
            // move cursor to start
            moveCursorToStart(aTextView)
        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        
        
        // remove the placeholder text when they start typing
        // first, see if the field is empty
        // if it's not empty, then the text should be black and not italic
        // BUT, we also need to remove the placeholder text if that's the only text
        // if it is empty, then the text should be the placeholder
        let newLength = count("textView.text".utf16) + count(text.utf16) - range.length
        self.enteredText = true
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        if newLength > 0 // have text, so don't show the placeholder
        {
            // check if the only text is the placeholder and remove it if needed
            // unless they've hit the delete button with the placeholder displayed
            if textView == reviewContent && textView.text == PLACEHOLDER_TEXT
            {
                if count(text.utf16) == 0 // they hit the back button
                {
                    return false // ignore it
                }
                applyNonPlaceholderStyle(textView)
                textView.text = ""
            }
            return true
        }
        else  // no text, so show the placeholder
        {
            applyPlaceholderStyle(textView, placeholderText: PLACEHOLDER_TEXT)
            moveCursorToStart(textView)
            self.enteredText = false
            return false
        }
        
    }
    
    
}

