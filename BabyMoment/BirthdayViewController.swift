//
//  BirthdayViewController.swift
//  BabyMoment
//
//  Created by Xing Zhou on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    var birthday :String?
    
    @IBOutlet weak var birthday_picker: UIDatePicker!
    
    @IBAction func submit_birthday(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyy"
        
        birthday = dateFormatter.stringFromDate(birthday_picker.date)
        print(birthday!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthday_picker.maximumDate = NSDate()
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoTabView" {
            let tabVC = segue.destinationViewController as? ViewController
            
            tabVC?.birthday = birthday
        }
    }
}
