//
//  MemeTableViewController.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/11/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
   override func viewDidAppear(animated: Bool) {
        if Meme.countAll() == 0 {
            performSegueWithIdentifier("showEditor", sender: self)
        }
        super.viewDidAppear(animated)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Meme.countAll()
    }
}