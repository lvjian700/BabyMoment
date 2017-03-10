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
            guard let realm = try? Realm() else { return }
            do {
                try realm.write {
                    model.text = newValue
                }
                self.messageDidChange?(self)
            } catch {
                print("Something wrong on updating text, newValue:\(newValue), oldValue: \(message)")
            }
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
