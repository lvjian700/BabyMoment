import Foundation
import RealmSwift
@testable import BabyMoment

func daysAgo(days:Int) -> NSDate {
    let now = NSDate()
    return now.dateByAddingDays(-days)
}

func saveMoment(m: Moment) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(m)
    }
}

class MomentFactories {
    static var birthday: NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.dateFromString("2015-09-11")
    }

    static func buildMoment() -> Moment {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let takenDate:NSDate! = formatter.dateFromString("2016-09-2")
        let uploadedAt:NSDate = daysAgo(3)

        return Moment(value: [
            "assetLocationId": "assetId",
            "uploadedAt":      uploadedAt,
            "photoTakenDate":  takenDate,
            "text":            "message"
        ])
    }

    static func createMoment() -> Moment {
        let moment = buildMoment()
        saveMoment(moment)

        return moment
    }
}

