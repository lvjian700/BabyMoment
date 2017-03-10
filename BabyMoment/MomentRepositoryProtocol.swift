import Foundation

protocol MomentRepositoryProtocol {
    func moments() -> [Moment]
    func create(moment: Moment)
    
    func subscribeToChanged(block: () -> Void)
    func unsubscribeFromChanged()
}
