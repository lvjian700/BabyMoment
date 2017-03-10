import Foundation
import RealmSwift

class MomentRepository: MomentRepositoryProtocol {
    var notificationToken: NotificationToken? = nil

    func moments() -> [Moment] {
        let realm = try! Realm()
        let results = realm.objects(Moment.self).sorted("uploadedAt", ascending: false)
        return Array<Moment>(results)
    }

    func create(moment: Moment) {
        moment.save()
    }

    func subscribeToChanged(block: () -> Void) {
        let realm = try! Realm()
        notificationToken = realm.objects(Moment.self).addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .Update(_, _, _, _):
                block()
                break
            default:
                print("No thing changes")
            }
        }
    }

    func unsubscribeFromChanged() {
        notificationToken?.stop()
    }
}
