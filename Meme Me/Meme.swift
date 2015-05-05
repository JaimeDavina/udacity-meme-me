//
//  Meme.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/11/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class Meme {
    var top = ""
    var bottom = ""
    var image = UIImage()
    var memedImage = UIImage()
    
    init(top: String, bottom: String, image: UIImage, memedImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memedImage = memedImage
    }
    
    func save() {
        // Add it to the memes array in the Application Delegate
        Meme.getStorage().memes.append(self)
    }
    
    class func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    
    class func findAll() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return Meme.getStorage().memes
    }
    
    class func countAll() -> Int {
        return Meme.getStorage().memes.count
    }
    
    class func getAtIndex(index: Int) -> Meme? {
        if Meme.getStorage().memes.count > index {
            return Meme.getStorage().memes[index]
        }
        return nil
    }
    
    class func removeAtIndex(index: Int) -> Meme? {
        if index > 0 && Meme.getStorage().memes.count > index {
            var memes = Meme.getStorage().memes
            memes.removeAtIndex(index)
        }
        return nil
    }
}
