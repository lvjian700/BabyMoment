import Foundation
import RealmSwift

class MomentViewModel {
    let model: Moment
    let birthday: NSDate
    let assetLocationId: String

    required init(_ momentModel: Moment, birthday: NSDate) {
        self.model     = momentModel
        self.birthday  = birthday
        self.assetLocationId = momentModel.assetLocationId
    }

    var messageDidChange: ((MomentViewModel) -> ())?

    var message: String {
        get {
            return model.text
        }
        set {
            let realm = try! Realm()
            try! realm.write {
                model.text = newValue
            }
            self.messageDidChange?(self)
        }
    }

    var photoTakenDesc: String {
        let takenDate: NSDate = self.model.photoTakenDate
        return takenDate.howOld(birthday)
    }

    var uploadedAtDesc: String {
        return model.uploadedAt.timeAgoSinceNow()
    }
}
