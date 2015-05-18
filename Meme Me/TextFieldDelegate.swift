//
//  TextFieldDelegate.swift
//  Meme Me
//
//  Created by Jerozan Jeyendrarasa on 5/5/15.
//  Copyright (c) 2015 Jero Jeyen. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
        textField.autocapitalizationType  = UITextAutocapitalizationType.AllCharacters
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Close the keyboard
        textField.resignFirstResponder()
        return true
    }
    
}