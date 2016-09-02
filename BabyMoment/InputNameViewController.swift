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
        nameTextField.delegate = self
        
        header.layer.shadowOffset = CGSize(width: 0, height: 1)
        header.layer.shadowRadius = 1
        header.layer.shadowOpacity = 0.1
    }
    
    override func viewDidAppear(animated: Bool) {
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
        BabyProfile.saveName(name)
    }
}

extension InputNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        saveName(nameTextField.text!)
        showNextPage()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        saveName(nameTextField.text!)
        showNextPage()
    }
}