import Foundation

protocol MomentRepositoryProtocol {
    func moments() -> [Moment]
    func create(_ moment: Moment)
    
    func subscribeToChanged(_ block: @escaping () -> Void)
    func unsubscribeFromChanged()
}
