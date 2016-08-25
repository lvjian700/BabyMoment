//
//  ChooseGenderViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class ChooseGenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
    }
    
    
    @IBAction func chooseGirl(sender: AnyObject) {
        let chooseDateVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChooseBirthdayViewController") as! ChooseBirthdayViewController
        navigationController?.pushViewController(chooseDateVC, animated: false)
    }
    
    @IBAction func chooseBoy(sender: AnyObject) {
        let chooseDateVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChooseBirthdayViewController") as! ChooseBirthdayViewController
        navigationController?.pushViewController(chooseDateVC, animated: false)
    }
    
}
