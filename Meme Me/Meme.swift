//
//  Meme.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/11/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

/// Handles saving, fetching, and deleteing memes
class Meme {
    /// The text on top of the Meme
    var top = ""
    /// The text on bottom of the Meme
    var bottom = ""
    /// The background image for the Meme
    var image = UIImage()
    /// The composited text and image that can be shared
    var memedImage = UIImage()
    

    /**
    Constructor function that sets the member variables
    
    :param: top The text on bottom of the meme
    :param: bottom The text on bottom of the meme
    :param: image The background image
    :param: memedImage The composited image and text
    */
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
    
    /**
    Saves the meme
    */
    func save() {
        Meme.getStorage().memes.append(self)
    }
    
    /**
    Get the object where the meme array is stored
    
    :returns: The object holds the memes
    */
    class func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    /**
    Returns all the memes
    
    :returns: The array of Meme objects
    */
    class func findAll() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return Meme.getStorage().memes
    }
    
    /**
    Returns the count of memes
    
    :returns The count of memes
    */
    class func countAll() -> Int {
        return Meme.getStorage().memes.count
    }
    
    /**
    Gets a meme at a particular index
    
    :param: index The index into the memes array
    :returns: Meme if one exists at the given index
    */
    class func getAtIndex(index: Int) -> Meme? {
        if Meme.getStorage().memes.count > index {
            return Meme.getStorage().memes[index]
        }
        return nil
    }
    
    /**
    Removes a meme at the given index
    
    :param: index The index of the Meme to delete
    */
    class func removeAtIndex(index: Int) {
        if index >= 0 && Meme.getStorage().memes.count > index {
            Meme.getStorage().memes.removeAtIndex(index)
        }
    }
}
