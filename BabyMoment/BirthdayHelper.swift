//
//  BirthdayHelper.swift
//  BabyMoment
//
//  Created by twcn  on 8/26/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import Foundation

extension NSDate {
    func howOld(birthday: NSDate) -> String {
        
        let cal:NSCalendar = NSCalendar.currentCalendar()
        let comps:NSDateComponents = cal.components([.Month, .Day], fromDate: birthday, toDate: self, options: NSCalendarOptions.WrapComponents)
        
        
        return "\(comps.month)个月\(comps.day)天"
    }
}