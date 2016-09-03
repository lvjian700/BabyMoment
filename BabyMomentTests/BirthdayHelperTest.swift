import XCTest
@testable import BabyMoment

class BirthdayHelperTest: XCTestCase {        
    func testHowOld() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let brithday:NSDate = formatter.dateFromString("2015-09-11")!
        let now:NSDate = formatter.dateFromString("2016-09-2")!
        
        XCTAssertEqual(now.howOld(brithday), "11个月22天")
    }
}
