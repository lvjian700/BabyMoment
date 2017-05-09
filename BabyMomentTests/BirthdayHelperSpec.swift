import Quick
import Nimble
@testable import BabyMoment

class BirthdayHelperSpec: QuickSpec {
    override func spec() {
        describe("howOld") {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            context("when brithday is 2015-09-11 and now is 2016-09-2") {
                var brithday: Date!
                var now: Date!

                beforeEach {
                    brithday = formatter.date(from: "2015-09-11")
                    now = formatter.date(from: "2016-09-2")
                }

                it("returns described age") {
                    expect(now.howOld(brithday)).to(equal("11个月22天"))
                }
            }
        }
    }
}
