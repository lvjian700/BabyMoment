import Foundation
import RealmSwift

class Moment: Object {
    dynamic var assetLocationId: String = ""
    dynamic var uploadedAt: NSDate = NSDate()
    dynamic var photoTakenDate: NSDate = NSDate()
    dynamic var text: String = ""
}

