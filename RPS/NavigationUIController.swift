//
//  MainViewController.swift
//  act-r
//
//  Created by Niels Taatgen on 4/2/15.
//  Copyright (c) 2015 Niels Taatgen. All rights reserved.
//

import UIKit

class NavigationUIController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("PrepareForSegue called")
    }
    
}
