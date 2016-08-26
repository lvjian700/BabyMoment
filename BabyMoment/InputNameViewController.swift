//
//  InputNameViewController.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/26/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class InputNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveName(sender: AnyObject) {
        saveName(nameTextField.text!)
        showNextPage()
    }
    
    private func showNextPage() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TabBarVC") as! TabBarVC
    }
    
    private func saveName(name: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(name, forKey: "Name")
        userDefaults.synchronize()
    }
}
