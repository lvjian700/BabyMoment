import Quick
import Nimble
import RealmSwift
@testable import BabyMoment

class BabyProfileSpec: QuickSpec {
    override func spec() {
        beforeEach {
            NSUserDefaults.resetStandardUserDefaults()
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        }

        describe("initWithUserDefault") {
            var baby: BabyProfile!
            var birthdayDate: NSDate!

            context("when a baby profile saved") {
                beforeEach {
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    birthdayDate = formatter.dateFromString("2015-09-11")

                    BabyProfile.saveName("xuebao")
                    BabyProfile.saveGender(Gender.Boy)
                    BabyProfile.saveBirthday(birthdayDate)

                    baby = BabyProfile.initWithUserDefault()
                }

                it("returns name")     { expect(baby.name)     == "xuebao"            }
                it("returns gender")   { expect(baby.gender)   == Gender.Boy.rawValue }
                it("returns birthday") { expect(baby.birthday) == birthdayDate        }
            }
        }

        describe("currentProfile") {
            context("when a baby profile saved") {
                var baby: BabyProfile!

                beforeEach {
                    baby = BabyProfile(value: ["name": "xuebao", "gender": Gender.Boy.rawValue, "birthday": NSDate()])
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
                baby = BabyProfile(value: ["name": "xuebao", "gender": Gender.Boy.rawValue, "birthday": NSDate()])

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
