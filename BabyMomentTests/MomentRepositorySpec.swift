import Quick
import Nimble
import RealmSwift
@testable import BabyMoment

class MomentRepositorySpec: QuickSpec {
    override func spec() {
        let realm = try! Realm()

        describe("#moments") {
            let repository = MomentRepository()

            beforeEach() {
                MomentFactories.buildMoment().save()
            }

            afterEach() {
                try! realm.write {
                    realm.deleteAll()
                }
            }

            it("returns moments") {
                expect(repository.moments()).to(haveCount(1))
            }
        }
    }
}
