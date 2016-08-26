//
//  DoubleMomentCell.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/25/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

class DoubleMomentCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var yearMonth: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var saveAction: ((content: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        saveAction?(content: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
    func setDate(date: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd"
        day.text = formatter.stringFromDate(date)
        
        formatter.dateFormat = "yyyy.MM"
        yearMonth.text = formatter.stringFromDate(date)
        
        let birday:String = NSUserDefaults.standardUserDefaults()
            .stringForKey("kBirthday")!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birdayDate:NSDate = dateFormatter.dateFromString(birday)!
        let oldText:String = date.howOld(birdayDate)
        time.text = oldText;
    }
    
    func setUploadedAt(date: NSDate) {
        let timeAgoText:String = date.timeAgoSinceNow()
        timeAgo.text = timeAgoText
    }
}
