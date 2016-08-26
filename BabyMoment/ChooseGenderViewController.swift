//
//  ChooseGenderViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

enum Gender: Int {
    case Girl, Boy
}

class ChooseGenderViewController: UIViewController {

    @IBOutlet weak var header: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    
    @IBAction func chooseGirl(sender: AnyObject) {
        showNextPage()
        setGender(.Girl)
    }
    
    @IBAction func chooseBoy(sender: AnyObject) {
        showNextPage()
        setGender(.Boy)
    }
    
    private func showNextPage() {
        let chooseDateVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChooseBirthdayViewController") as! ChooseBirthdayViewController
        navigationController?.pushViewController(chooseDateVC, animated: true)
    }
    
    private func setGender(gender: Gender) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(gender.rawValue, forKey: "Gender")
        userDefaults.synchronize()
    }
}
