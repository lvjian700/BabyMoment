//
//  BabyProfile.swift
//  BabyMoment
//
//  Created by twcn  on 9/1/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import Foundation
import RealmSwift

enum Gender: Int {
    case Girl, Boy
}

class BabyProfile: Object {
    dynamic var name = ""
    dynamic var gender = ""
    dynamic var birthday: NSDate?

    class func load_from_setting() -> BabyProfile? {
        return nil
    }
    
    class func saveName(name: String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "kBabyName")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func saveGender(gender: Gender) {
        NSUserDefaults.standardUserDefaults().setObject(gender.rawValue, forKey: "kBabyGender")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func saveBirthday(birthday: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday:String = formatter.stringFromDate(birthday)
        
        NSUserDefaults.standardUserDefaults().setObject(birthday, forKey: "kBabyBirthday")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
