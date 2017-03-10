import Foundation
import RealmSwift

enum Gender: Int {
    case Girl, Boy
}

class BabyProfile: Object {
    dynamic var name = ""
    dynamic var gender = Gender.Girl.rawValue
    dynamic var birthday: NSDate?
    
    class func initWithUserDefault() -> BabyProfile {
        let name:String = NSUserDefaults.standardUserDefaults().stringForKey("kBabyName")!
        let gender:Int = NSUserDefaults.standardUserDefaults().integerForKey("kBabyGender")
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayDate:NSDate = formatter.dateFromString(NSUserDefaults.standardUserDefaults().stringForKey("kBabyBirthday")!)!
        
        return BabyProfile(value: ["name": name, "gender": gender, "birthday": birthdayDate])
    }
    
    class func saveName(name: String) {
        NSUserDefaults.standardUserDefaults().setObject(name, forKey: "kBabyName")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func saveGender(gender: Gender) {
        NSUserDefaults.standardUserDefaults().setObject(gender.rawValue, forKey: "kBabyGender")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func saveBirthday(birthday: NSDate) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday:String = formatter.stringFromDate(birthday)
        
        NSUserDefaults.standardUserDefaults().setObject(birthday, forKey: "kBabyBirthday")
        NSUserDefaults.standardUserDefaults().synchronize()
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
