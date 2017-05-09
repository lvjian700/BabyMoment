import Quick
import Nimble
import RealmSwift
@testable import BabyMoment

class BabyProfileSpec: QuickSpec {
    override func spec() {
        beforeEach {
            UserDefaults.resetStandardUserDefaults()
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }

        describe("initWithUserDefault") {
            var baby: BabyProfile!
            var birthdayDate: Date!

            context("when a baby profile saved") {
                beforeEach {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    birthdayDate = formatter.date(from: "2015-09-11")

                    BabyProfile.saveName("xuebao")
                    BabyProfile.saveGender(Gender.boy)
                    BabyProfile.saveBirthday(birthdayDate)

                    baby = BabyProfile.initWithUserDefault()
                }

                it("returns name")     { expect(baby.name)     == "xuebao"            }
                it("returns gender")   { expect(baby.gender)   == Gender.boy.rawValue }
                it("returns birthday") { expect(baby.birthday) == birthdayDate        }
            }
        }

        describe("currentProfile") {
            context("when a baby profile saved") {
                var baby: BabyProfile!

                beforeEach {
                    baby = BabyProfile(value: ["name": "xuebao", "gender": Gender.boy.rawValue, "birthday": Date()])
                    baby.save()
                }

                it("returns current baby") {
                    expect(BabyProfile.currentProfile()!).to(equal(baby))
                }
            }

            context("when there is no profile saved") {
                it("returns nil") { expect(BabyProfile.currentProfile()).to(beNil()) }
            }
        }

        describe("save") {
            var baby: BabyProfile!
            var expected: BabyProfile!

            beforeEach {
                baby = BabyProfile(value: ["name": "xuebao", "gender": Gender.boy.rawValue, "birthday": Date()])

                baby.save()

                let realm = try! Realm()
                expected = realm.objects(BabyProfile.self).first!
            }

            it("saves profile") {
                expect(baby).to(equal(expected))
            }
        }
    }
}
