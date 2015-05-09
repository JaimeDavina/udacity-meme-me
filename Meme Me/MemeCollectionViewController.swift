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
        // set the Edit/Done button to the nav bar left button
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Display editor automatically if no memes
        if Meme.countAll() == 0 {
            performSegueWithIdentifier("showEditor", sender: self)
        }
        collectionView!.reloadData()
        // disable the button if there are no memes (after a delete)
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView!.reloadData()
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
    
    @IBAction func didPressDelete(sender: UIButton) {
        // need to get to the cell from the button
        let cell = sender.superview!.superview! as! MemeCollectionViewCell
        let index = collectionView!.indexPathForCell(cell)!
        Meme.removeAtIndex(index.row)
        collectionView!.deleteItemsAtIndexPaths([index]);
        setEditing(false, animated: true)
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.countAll()
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if !editing {
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