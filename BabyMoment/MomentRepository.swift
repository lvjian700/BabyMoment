import Foundation
import RealmSwift

class MomentRepository: MomentRepositoryProtocol {
    var notificationToken: NotificationToken? = nil

    func defaultRealm() -> Realm? {
        guard let realm = try? Realm() else {
            print("Can not load realm")
            return nil
        }

        return realm;
    }

    func moments() -> [Moment] {
        guard let realm = defaultRealm() else { return [] }

        let results = realm.objects(Moment.self).sorted(byKeyPath: "uploadedAt", ascending: false)
        return Array<Moment>(results)
    }

    func create(_ moment: Moment) {
        guard let realm = defaultRealm() else { return }
        do {
            try realm.write {
                realm.add(moment)
            }
        } catch {
            print("Something wrong on saveing moment uploadedAt: \(moment.uploadedAt)")
        }
    }

    func subscribeToChanged(_ block: @escaping () -> Void) {
        guard let realm = defaultRealm() else { return }

        notificationToken = realm.objects(Moment.self).addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .update(_, _, _, _):
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
