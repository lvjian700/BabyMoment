import Foundation

class MomentsViewModel {
    var cellViewModels: [MomentViewModel]?

    let repository:     MomentRepositoryProtocol
    let birthday:       NSDate

    required init(_ repository: MomentRepositoryProtocol, birthday: NSDate) {
        self.repository = repository
        self.birthday = birthday
    }

    func configureCellModels() {
        self.cellViewModels = repository.moments().map { [weak self] (moment) -> MomentViewModel in
            return MomentViewModel(moment, birthday: self!.birthday)
        }
    }

    func createMoment(assetLocationId: String, photoTakenDate: NSDate) {
        let moment = Moment(value: [
            "assetLocationId": assetLocationId,
            "photoTakenDate":  photoTakenDate
        ])

        repository.create(moment)
    }

    func subscribeToChanged(block: () -> Void) {
        repository.subscribeToChanged(block)
    }

    func unsubscribeFromChanged() {
        repository.unsubscribeFromChanged()
    }
}
