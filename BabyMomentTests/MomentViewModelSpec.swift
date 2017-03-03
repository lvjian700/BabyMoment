import Quick
import Nimble
import DateTools

@testable import BabyMoment

func daysAgo(days:Int) -> NSDate {
    let now = NSDate()
    return now.dateByAddingDays(-days)
}

class MomentViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: MomentViewModel!

        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        beforeEach {
            let birthday:NSDate!  = formatter.dateFromString("2015-09-11")
            let takenDate:NSDate! = formatter.dateFromString("2016-09-2")
            let uploadedAt:NSDate = daysAgo(3)

            let moment = Moment(value: [
                "assetLocationId": "assetId",
                "uploadedAt": uploadedAt,
                "photoTakenDate": takenDate,
                "text": "message"
                ])

            viewModel = MomentViewModel(moment, birthday: birthday)
        }

        describe("message") {
            it("returns message") {
                expect(viewModel.message).to(equal("message"))
            }
        }

        describe("photoTakenDesc") {
            it("return photoTakens") {
                expect(viewModel.photoTakenDesc).to(equal("11个月22天"))
            }
        }

        describe("uploadedAtDesc") {
            it("return uploaedAt") {
                expect(viewModel.uploadedAtDesc).to(equal("3 days ago"))
            }
        }

        describe("assetLocationId") {
            it("returns asset location id") {
                expect(viewModel.assetLocationId).to(equal("assetId"))
            }
        }
    }
}
