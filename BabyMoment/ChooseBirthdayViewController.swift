//
//  ChooseBirthdayViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class ChooseBirthdayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
    }
    
    @IBAction func chooseDate(sender: AnyObject) {
        setBirthday(datePicker.date)
        showNextPage()
    }
    
    private func showNextPage() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarVC") as! TabBarVC
    }
    
    private func setBirthday(date: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(formatter.stringFromDate(datePicker.date), forKey: "Birthday")
        userDefaults.synchronize()
    }
}
