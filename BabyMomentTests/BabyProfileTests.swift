import XCTest
import RealmSwift
@testable import BabyMoment


class BabyProfileTests: XCTestCase {
    
    override func setUp() {
        NSUserDefaults.resetStandardUserDefaults()
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
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
    
    func test_initWithUserDefault_should_return_a_baby_profile() {
        BabyProfile.saveName("xuebao")
        BabyProfile.saveGender(Gender.Boy)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayDate: NSDate = formatter.dateFromString("2015-09-11")!
        BabyProfile.saveBirthday(birthdayDate)
        
        let baby: BabyProfile = BabyProfile.initWithUserDefault()
        XCTAssertEqual(baby.name, "xuebao")
        XCTAssertEqual(baby.gender, Gender.Boy.rawValue)
        XCTAssertEqual(baby.birthday, birthdayDate)
    }
    
    func test_currentProfile_should_return_nil() {
        XCTAssertNil(BabyProfile.currentProfile())
    }
    
    func test_currentProfile_should_return_current_profile() {
        let baby: BabyProfile = BabyProfile(value: ["name": "xuebao", "gender": Gender.Boy.rawValue, "birthday": NSDate()])
        baby.save()
        
        XCTAssertEqual(BabyProfile.currentProfile()!, baby)
    }
    
    func test_save_should_save_baby_profile() {
        let baby: BabyProfile = BabyProfile(value: ["name": "xuebao", "gender": Gender.Boy.rawValue, "birthday": NSDate()])
        
        baby.save()
        
        let realm = try! Realm()
        let ret = realm.objects(BabyProfile.self).first!
        
        XCTAssertEqual(ret, baby)
    }
}
