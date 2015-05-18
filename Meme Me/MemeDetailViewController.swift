//
//  MemeDetailViewController.swift
//  Meme Me
//
//  Created by Jerozan Jeyendrarasa on 5/13/15.
//  Copyright (c) 2015 Jero Jeyen. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    var currentMeme: Meme!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = self.currentMeme.memeImg
    }
}