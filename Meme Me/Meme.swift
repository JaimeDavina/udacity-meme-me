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
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(self)
    }
    
    class func findAll() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    class func countAll() -> Int {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes.count
    }
}
