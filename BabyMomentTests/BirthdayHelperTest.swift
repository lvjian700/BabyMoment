//
//  BirthdayHelperTest.swift
//  BabyMoment
//
//  Created by twcn  on 8/26/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import XCTest

class BirthdayHelperTest: XCTestCase {        
    func testHowOld() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date:NSDate = formatter.dateFromString("2015-09-11")!
        let old:String = NSDate().howOld(date)
        XCTAssertEqual(old, "11个月15天")
    }
}
