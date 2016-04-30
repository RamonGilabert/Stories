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

    mainController.view.addSubview(loadingView)

    window?.makeKeyAndVisible()

    delay(0.2) { self.animate() }

    UIApplication.sharedApplication().statusBarHidden = true

    Sound.prepareSounds()

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

  // MARK: - 3D touch

  func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
    switch(shortcutItem.localizedTitle) {
    default:
      break
    }
  }
}
