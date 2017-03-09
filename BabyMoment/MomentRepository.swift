import Foundation
import RealmSwift

class MomentRepository: MomentRepositoryProtocol {
    func moments() -> [Moment] {
        let realm = try! Realm()
        let results = realm.objects(Moment.self).sorted("uploadedAt", ascending: false)
        return Array<Moment>(results)
    }
    
    func create(moment: Moment) {
        
    }
    
    func subscribeToChanged(block: () -> Void) {
    }
    
    func unsubscribeFromChanged() {
        
    }
}
