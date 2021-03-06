import Foundation
import RealmSwift
import DateToolsSwift
@testable import BabyMoment

func daysAgo(_ days:Int) -> Date {
    let now = Date()
    return now.add(TimeChunk(seconds: 0, minutes: 0, hours: 0, days: -days, weeks: 0, months: 0, years: 0))
}

func saveMoment(_ m: Moment) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(m)
    }
}

class MomentFactories {
    static var birthday: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: "2015-09-11")
    }

    static func buildMoment() -> Moment {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let takenDate:Date! = formatter.date(from: "2016-09-2")
        let uploadedAt:Date = daysAgo(3)

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

