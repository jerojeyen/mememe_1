//
//  ViewController.swift
//  Meme Me
//
//  Created by Jerozan Jeyendrarasa on 4/27/15.
//  Copyright (c) 2015 Jero Jeyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Instantiate delegate class for textfield
    let textFieldDelegate = TextFieldDelegate()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Default settings for both text fields
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeWidthAttributeName: -2,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        ]
        
        topField.defaultTextAttributes = memeTextAttributes
        topField.text = "TOP"
        topField.textAlignment = NSTextAlignment.Center
        topField.delegate = textFieldDelegate
        
        bottomField.defaultTextAttributes = memeTextAttributes
        bottomField.text = "BOTTOM"
        bottomField.textAlignment = NSTextAlignment.Center
        bottomField.delegate = textFieldDelegate
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Disable camero button if the camera is not available (emulators)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //Disable share button if we do not have any image
        if (imageView.image == nil) {
            shareButton.enabled = false
        }
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func pickAnImageFromLibrairy(sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveMemeMe(sender: UIBarButtonItem) {
        //Save button is a cancel button if there is no image
        if (imageView.image == nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            saveMeme()
            println("saved ! ")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        var activityVC = UIActivityViewController(activityItems: [self.generateMemedImage()], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {(s: String!, completed: Bool, items: [AnyObject]!, error:NSError!) in
            self.saveMeme()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
            
            //Changing save button and enabling share button
            saveButton.title = "Save"
            shareButton.enabled = true
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func generateMemedImage() -> UIImage
    {
        //Hide toolbars
        topBar.hidden = true
        bottomBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Show toolbars
        topBar.hidden = false
        bottomBar.hidden = false
        
        return memedImage
    }
    
    func saveMeme() {
        var meme = Meme(img: imageView.image!, topText: topField.text!, bottomText: bottomField.text!, memeImg: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)

    }
}

