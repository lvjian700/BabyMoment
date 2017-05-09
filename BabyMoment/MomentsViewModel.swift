import Foundation

class MomentsViewModel {
    var cellViewModels: [MomentViewModel]?

    let repository:     MomentRepositoryProtocol
    let birthday:       Date

    required init(_ repository: MomentRepositoryProtocol, birthday: Date) {
        self.repository = repository
        self.birthday = birthday
    }

    func configureCellModels() {
        self.cellViewModels = repository.moments().map { [weak self] (moment) -> MomentViewModel in
            return MomentViewModel(moment, birthday: self!.birthday)
        }
    }

    func createMoment(_ assetLocationId: String, photoTakenDate: Date) {
        let moment = Moment(value: [
            "assetLocationId": assetLocationId,
            "photoTakenDate":  photoTakenDate
        ])

        repository.create(moment)
    }

    func subscribeToChanged(_ block: @escaping () -> Void) {
        repository.subscribeToChanged(block)
    }

    func unsubscribeFromChanged() {
        repository.unsubscribeFromChanged()
    }
}
