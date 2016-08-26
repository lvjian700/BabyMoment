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
    @IBOutlet weak var header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
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
