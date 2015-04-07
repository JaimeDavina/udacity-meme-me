//
//  ViewController.swift
//  Meme Me
//
//  Created by Russell Austin on 4/2/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    let topPlaceholderText = "TOP"
    let bottomPlaceholderText = "BOTTOM"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3
        ]
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
   
    @IBAction func didBeginEditingTopText(sender: UITextField) {
        if sender.text! == topPlaceholderText {
            sender.text = ""
        }
    }
    @IBAction func didBeginEditingBottomText(sender: UITextField) {
        if sender.text! == bottomPlaceholderText {
            sender.text = ""
        }
    }
    @IBAction func didEndEditingTopText(sender: UITextField) {
    }
    @IBAction func didEndEditingBottomText(sender: UITextField) {
    }
    
    // MARK: - Keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }


}

