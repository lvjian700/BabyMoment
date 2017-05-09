import Foundation
import RealmSwift

enum Gender: Int {
    case girl, boy
}

class BabyProfile: Object {
    dynamic var name = ""
    dynamic var gender = Gender.girl.rawValue
    dynamic var birthday: Date?
    
    class func initWithUserDefault() -> BabyProfile {
        let name:String = UserDefaults.standard.string(forKey: "kBabyName")!
        let gender:Int = UserDefaults.standard.integer(forKey: "kBabyGender")
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayDate:Date = formatter.date(from: UserDefaults.standard.string(forKey: "kBabyBirthday")!)!
        
        return BabyProfile(value: ["name": name, "gender": gender, "birthday": birthdayDate])
    }
    
    class func saveName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "kBabyName")
        UserDefaults.standard.synchronize()
    }
    
    class func saveGender(_ gender: Gender) {
        UserDefaults.standard.set(gender.rawValue, forKey: "kBabyGender")
        UserDefaults.standard.synchronize()
    }
    
    class func saveBirthday(_ birthday: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday:String = formatter.string(from: birthday)
        
        UserDefaults.standard.set(birthday, forKey: "kBabyBirthday")
        UserDefaults.standard.synchronize()
    }
}

extension BabyProfile {
    
    class func currentProfile() -> BabyProfile? {
        guard let realm = try? Realm() else { return nil }
        return realm.objects(BabyProfile.self).first
    }
    
    func save() {
        guard let realm = try? Realm() else { return }
        
        do {
            try realm.write {
                realm.add(self)
            }
        } catch {
            print("Something wrong on saving BabyProfile")
        }
    }
}
