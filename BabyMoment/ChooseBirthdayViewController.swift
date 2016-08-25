//
//  ChooseBirthdayViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class ChooseBirthdayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
    }
    
    @IBAction func chooseDate(sender: AnyObject) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarVC") as! TabBarVC
    }
    
}
