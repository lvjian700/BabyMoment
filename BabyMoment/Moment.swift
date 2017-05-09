import Foundation
import RealmSwift

class Moment: Object {
    dynamic var assetLocationId: String = ""
    dynamic var uploadedAt: Date = Date()
    dynamic var photoTakenDate: Date = Date()
    dynamic var text: String = ""
}

