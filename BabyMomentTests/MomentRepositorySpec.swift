import Quick
import Nimble
import RealmSwift
@testable import BabyMoment

class MomentRepositorySpec: QuickSpec {
    override func spec() {
        let realm = try! Realm()
        let repository = MomentRepository()

        afterEach {
            try! realm.write {
                realm.deleteAll()
            }
        }

        describe("#moments") {
            beforeEach {
                MomentFactories.createMoment()
            }

            it("returns moments") {
                expect(repository.moments()).to(haveCount(1))
            }
        }

        describe("#create") {
            beforeEach {
                let moment = MomentFactories.buildMoment()
                repository.create(moment)
            }

            it("creates a moment") {
                expect(repository.moments()).to(haveCount(1))
            }
        }

        describe("subscribeToChanged") {
            var isChangedFired = false

            beforeEach() {
                repository.subscribeToChanged {
                    isChangedFired = true
                }

                MomentFactories.createMoment()
            }

            afterEach() {
                repository.unsubscribeFromChanged()
            }

            it("fires the changed") {
                expect(isChangedFired).toEventually(beTrue())
            }
        }

        describe("unsubscribeFromChanged") {
            var isChangedFired = false

            beforeEach() {
                repository.subscribeToChanged {
                    isChangedFired = true
                }

                repository.unsubscribeFromChanged()
                MomentFactories.createMoment()
            }

            it("won't fires the changed") {
                expect(isChangedFired).toEventually(beFalse())
            }
        }
    }
}

