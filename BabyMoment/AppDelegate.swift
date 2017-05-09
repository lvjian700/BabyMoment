import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controllerId: String = BabyProfile.currentProfile() == nil ? "BabyProfileWizardNavVC" : "TabBarVC";
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: controllerId)
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
}

