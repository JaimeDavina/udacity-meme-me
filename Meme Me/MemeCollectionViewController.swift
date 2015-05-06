//
//  MemeCollectionViewController.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/11/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.reloadData()
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            navigationItem.rightBarButtonItem?.enabled = false
        } else {
            navigationItem.rightBarButtonItem?.enabled = true
        }
        collectionView?.reloadData()
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        if let meme = Meme.getAtIndex(indexPath.row) {
            cell.memeImageView.image = meme.memedImage
        }
        cell.deleteButton.hidden = !editing
        cell.deleteButton.addTarget(self, action: "didPressDelete:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    @IBAction func didPressDelete(sender: AnyObject) {
        println("DELETE")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.countAll()
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !editing {
            selectedIndex = indexPath.row
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
   
    @IBAction func didPressAdd(sender: AnyObject) {
        performSegueWithIdentifier("showEditor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            var destination = segue.destinationViewController as! DetailViewController
            if let meme = Meme.getAtIndex(selectedIndex!) {
                destination.meme = meme
            }
        }
    }
}