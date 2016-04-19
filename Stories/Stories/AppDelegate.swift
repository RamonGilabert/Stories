import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var welcomeController: WelcomeController = WelcomeController()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()
    window?.frame = UIScreen.mainScreen().bounds
    window?.rootViewController = welcomeController
    window?.makeKeyAndVisible()

    UIApplication.sharedApplication().statusBarHidden = true

    return true
  }
}
