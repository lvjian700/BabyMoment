import Foundation
import RealmSwift
import DateToolsSwift

class MomentViewModel {
    let model: Moment
    let birthday: Date
    let assetLocationId: String

    required init(_ momentModel: Moment, birthday: Date) {
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
        let takenDate: Date = self.model.photoTakenDate as Date
        return takenDate.howOld(birthday)
    }

    var uploadedAtDesc: String {
        return self.model.uploadedAt.timeAgoSinceNow
    }
}
