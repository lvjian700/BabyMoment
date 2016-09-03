import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controllerId: String = BabyProfile.currentProfile() == nil ? "BabyProfileWizardNavVC" : "TabBarVC";
        let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier(controllerId)
        
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
}

