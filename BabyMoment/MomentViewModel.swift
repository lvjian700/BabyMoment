import Foundation

class MomentViewModel {
    let model: Moment
    let birthday: NSDate
    let assetLocationId: String

    required init(_ momentModel: Moment, birthday: NSDate) {
        self.model     = momentModel
        self.birthday  = birthday
        self.assetLocationId = momentModel.assetLocationId
    }

    var message: String {
        return model.text
    }

    var photoTakenDesc: String {
        let takenDate: NSDate = self.model.photoTakenDate
        return takenDate.howOld(birthday)
    }

    var uploadedAtDesc: String {
        return model.uploadedAt.timeAgoSinceNow()
    }
}
