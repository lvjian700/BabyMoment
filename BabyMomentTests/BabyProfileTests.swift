import XCTest
@testable import BabyMoment

class BabyProfileTests: XCTestCase {
    
    override func setUp() {
        NSUserDefaults.resetStandardUserDefaults()
    }
    
    func test_saveName_should_save_to_default_setting() {
        BabyProfile.saveName("xuebao")
        let babyName:String = NSUserDefaults.standardUserDefaults().stringForKey("kBabyName")!
        
        XCTAssertEqual(babyName, "xuebao")
    }
    
    func test_saveGender_should_save_to_default_setting() {
        BabyProfile.saveGender(Gender.Boy)
        let babyGender:NSInteger = NSUserDefaults.standardUserDefaults().integerForKey("kBabyGender")
        
        XCTAssertEqual(Gender(rawValue: babyGender), Gender.Boy)
    }
    
    func test_saveBirthday_should_save_to_default_setting() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        BabyProfile.saveBirthday(formatter.dateFromString("2015-09-11")!)
        
        let brithday:String = NSUserDefaults.standardUserDefaults().stringForKey("kBabyBirthday")!
        
        XCTAssertEqual(brithday, "2015-09-11")
    }
}
