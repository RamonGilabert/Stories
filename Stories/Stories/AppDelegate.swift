import UIKit
import Sugar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var mainController: MainController = MainController()

  lazy var loadingView: LoadingView = {
    let loadingView = LoadingView()
    loadingView.frame = UIScreen.mainScreen().bounds

    return loadingView
  }()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow()
    window?.frame = UIScreen.mainScreen().bounds
    window?.rootViewController = mainController

    //mainController.view.addSubview(loadingView)

    window?.makeKeyAndVisible()

    //delay(0.2) { self.animate() } TODO: Put back.

    UIApplication.sharedApplication().statusBarHidden = true

    return true
  }

  // MARK: - Animation

  func animate() {
    UIView.animateWithDuration(0.7, animations: {
      self.loadingView.moon.transform = CGAffineTransformMakeTranslation(0, -500)
      }, completion: { _ in
        UIView.animateWithDuration(0.3, animations: {
          self.loadingView.alpha = 0
          }, completion: { _ in
            self.mainController.animate()
        })
    })
  }
}
