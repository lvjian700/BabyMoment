import Foundation

extension Date {
    func howOld(_ birthday: Date) -> String {
        
        let cal:Calendar = Calendar.current
        let comps = cal.dateComponents([.month, .day], from: birthday, to: self)
        
        return "\(comps.month!)个月\(comps.day!)天"
    }
}
