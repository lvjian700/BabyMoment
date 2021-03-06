import Quick
import Nimble
import RealmSwift
@testable import BabyMoment

class MockMomentRepository: MomentRepositoryProtocol {
    var inMemory: [Moment] = []
    var changedBlock: (() -> Void)?

    func moments() -> [Moment] {
        return [ Moment() ]
    }

    func create(_ moment: Moment) {
        inMemory.append(moment)
    }

    func fireChangedAsync() {
        DispatchQueue.main.async { [weak self] in
            if let block = self?.changedBlock {
                block()
            }
        }
    }

    func subscribeToChanged(_ block: @escaping () -> Void) {
        changedBlock = block
    }

    func unsubscribeFromChanged() {
        changedBlock = nil
    }
}

class MomentsViewModelSpec: QuickSpec {
    override func spec() {
        let repository = MockMomentRepository()
        let birthday: Date! = MomentFactories.birthday

        describe("#configureCellModels") {
            let viewModel  = MomentsViewModel(repository, birthday: birthday)

            beforeEach {
                viewModel.configureCellModels()
            }

            it("loads cell view models") {
                expect(viewModel.cellViewModels).to(haveCount(1))
            }
        }

        describe("#createMoment") {
            let viewModel = MomentsViewModel(repository, birthday: birthday)
            let photoDate = Date()

            beforeEach {
                viewModel.createMoment("locationId", photoTakenDate: photoDate)
            }

            it("creates a moment") {
                expect(repository.inMemory).to(haveCount(1))
            }
        }

        describe("#subscribeMomentChanged") {
            let viewModel = MomentsViewModel(repository, birthday: birthday)
            var isChangedFired = false

            beforeEach {
                viewModel.subscribeToChanged {
                    isChangedFired = true
                }
                repository.fireChangedAsync()
            }

            it("notices moment changed") {
                expect(isChangedFired).toEventually(beTrue())
            }
        }

        describe("#unsubscribeMomentChanged") {
            let viewModel = MomentsViewModel(repository, birthday: birthday)
            var isChangedFired = false

            beforeEach {
                viewModel.subscribeToChanged {
                    isChangedFired = true
                }
                viewModel.unsubscribeFromChanged()
                repository.fireChangedAsync()
            }

            it("won't get changed notification") {
                expect(isChangedFired).toEventually(beFalse())
            }
        }

    }
}
