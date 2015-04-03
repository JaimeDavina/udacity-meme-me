//
//  ViewController.swift
//  Meme Me
//
//  Created by Russell Austin on 4/2/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3
        ]
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

