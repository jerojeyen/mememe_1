//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Jerozan Jeyendrarasa on 5/12/15.
//  Copyright (c) 2015 Jero Jeyen. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //get memes from AppDelegate memes array
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        
        //Reload data to get new memes
        self.collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCellIdentifier", forIndexPath: indexPath)as! MemeCollectionViewCell
        let meme = self.memes[indexPath.row]
        
        // set image
        cell.img.image = meme.memeImg
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("memeDetailViewControllerIdentifier")! as! MemeDetailViewController
        
        controller.currentMeme = self.memes[indexPath.row]
        
        //Sending meme to detail view
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func addMeme(sender: UIBarButtonItem) {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("memeEditorViewControllerIdentifier")! as! ViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
