//
//  Meme.swift
//  Meme Me
//
//  Created by Jerozan Jeyendrarasa on 5/11/15.
//  Copyright (c) 2015 Jero Jeyen. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject{
    var img: UIImage!
    var memeImg: UIImage!
    var topText: String!
    var bottomText: String!
    
    init(img: UIImage, topText: String, bottomText: String, memeImg: UIImage) {
        self.img = img
        self.topText = topText
        self.bottomText = bottomText
        self.memeImg = memeImg
    }
}