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
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    @IBAction func chooseDate(sender: AnyObject) {
        setBirthday(datePicker.date)
        showNextPage()
    }
    
    private func showNextPage() {
        let inputNameVC =
            UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("InputNameViewController") as! InputNameViewController
        navigationController?.pushViewController(inputNameVC, animated: true)
    }
    
    private func setBirthday(date: NSDate) {
        BabyProfile.saveBirthday(datePicker.date)
    }
}
