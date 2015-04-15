//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/11/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if Meme.countAll() == 0 {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            performSegueWithIdentifier("showEditor", sender: self)
        }
    }
}