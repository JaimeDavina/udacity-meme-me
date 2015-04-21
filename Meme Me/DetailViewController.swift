//
//  File.swift
//  Meme Me
//
//  Created by Ra Ra Ra on 4/20/15.
//  Copyright (c) 2015 Russell Austin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = meme.memedImage
    }
}
