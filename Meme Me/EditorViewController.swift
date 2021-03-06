//
//  ViewController.swift
//  Meme Me
//
//  Created by Russell Austin on 4/2/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

/// Allows text entry and image selection to create a Meme
class EditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    let topPlaceholderText = "TOP"
    let bottomPlaceholderText = "BOTTOM"
    var currentTextField: UITextField?
    
    var editMeme: Meme?
   
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
   
    /**
    Sets up the view. Loads an existing Meme's data if one is set
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // font setup
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3
        ]
        
        // text field setup
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
        
        // set the delegate
        topText.delegate = self
        bottomText.delegate = self
        
        // enable the camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // if existing meme was set during segue to this controller
        if let meme = editMeme {
            topText.text = meme.top
            bottomText.text = meme.bottom
            memeImageView.image = meme.image
        }
        
    }
    
    /// Runs when the view appears
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    /// Runs when the view disappears
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - TextField
    
    func textFieldDidBeginEditing(textField: UITextField) {
        hidePlaceholderText(textField)
        currentTextField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        showPlaceholderText(textField)
        currentTextField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func hidePlaceholderText(textField: UITextField) {
        if textField == topText && textField.text! == topPlaceholderText {
            textField.text = ""
        }
        if textField == bottomText && textField.text! == bottomPlaceholderText {
            textField.text = ""
        }
    }
    
    private func showPlaceholderText(textField: UITextField) {
        if textField == topText && textField.text! == "" {
            textField.text = topPlaceholderText
        }
        if textField == bottomText && textField.text! == "" {
            textField.text = bottomPlaceholderText
        }
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
        if let textField = currentTextField {
            if textField == bottomText {
                self.view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    @IBAction func didPressActivity(sender: UIBarButtonItem) {
        let image = makeMemeImage()
        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activity.completionWithItemsHandler = { (type: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) in
            if completed {
                var backgroundImage = self.memeImageView.image == nil ? UIImage() : self.memeImageView.image
                var meme = Meme(
                    top: self.topText.text,
                    bottom: self.bottomText.text,
                    image: backgroundImage!,
                    memedImage: image
                )
                meme.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(activity, animated: true, completion: nil)
    }
    
    /**
    Creates an image from the text and background image
    
    :returns: The composited image
    */
    private func makeMemeImage() -> UIImage {
        
        hideToolbars()
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        showToolbars()
        
        return image
    }
    
    private func hideToolbars() {
        navBar.hidden = true
        bottomToolbar.hidden = true
    }
    
    private func showToolbars() {
        navBar.hidden = false
        bottomToolbar.hidden = false
    }
    
    @IBAction func didPressCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// brings up the camera roll
    @IBAction func didPressAlbum(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    /// shows the camera via the UIImage picker
    @IBAction func didPressCamera(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            memeImageView.image = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}