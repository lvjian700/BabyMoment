import Foundation

extension Date {
    func howOld(_ birthday: Date) -> String {
        
        let cal:Calendar = Calendar.current
        let comps:DateComponents = (cal as NSCalendar).components([.month, .day], from: birthday, to: self, options: NSCalendar.Options.wrapComponents)
        
        
        return "\(comps.month)个月\(comps.day)天"
    }
}
