import UIKit
import MessageUI

class MainController: GeneralController {

  lazy var welcomeController: WelcomeController = { [unowned self] in
    let controller = WelcomeController()
    controller.delegate = self
    controller.view.frame = UIScreen.mainScreen().bounds

    return controller
  }()

  lazy var engineController: EngineController = { [unowned self] in
    let controller = EngineController()
    controller.view.frame = UIScreen.mainScreen().bounds
    controller.delegate = self

    return controller
  }()

  lazy var menuController: MenuController = { [unowned self] in
    let controller = MenuController()
    controller.view.frame = UIScreen.mainScreen().bounds
    controller.delegate = self

    return controller
  }()

  lazy var storyController: StoryController = { [unowned self] in
    let controller = StoryController()
    controller.view.frame = UIScreen.mainScreen().bounds
    controller.delegate = self

    return controller
  }()

  lazy var finaleController: FinaleController = {
    let controller = FinaleController()
    controller.view.frame = UIScreen.mainScreen().bounds

    return controller
  }()

  lazy var mailController: MFMailComposeViewController = { [unowned self] in
    let controller = MFMailComposeViewController()
    controller.setToRecipients([Constant.email])
    controller.setSubject(Text.Contact.title)
    controller.setMessageBody(Text.Contact.message, isHTML: false)
    controller.delegate = self

    return controller
  }()

  var controllers = []

  override func viewDidLoad() {
    super.viewDidLoad()

    controllers = [welcomeController, engineController, storyController]
//    view.addSubview(welcomeController.view)
    view.addSubview(engineController.view)
  }

  // MARK: - Animation

  func animate() {
    welcomeController.animate()
  }

  // MARK: - Helper methods

  func changeRootView<T : Animatable>(controller: T) {
    controllers.forEach { $0.view.removeFromSuperview() }

    if let controller = controller as? UIViewController {
      controller.view.alpha = 0
      view.addSubview(controller.view)
    }

    controller.prepareAnimate()
    controller.animate()
  }

  func presentMenu() {
    menuController.modalPresentationStyle = .Custom
    menuController.transitioningDelegate = menuController.transition

    presentViewController(menuController, animated: true, completion: nil)
  }

  func presentGithub() {
    guard let URL = NSURL(string: Constant.github) else { return }
    presentViewController(WebsiteController(URL: URL), animated: true, completion: nil)
  }

  func presentContact() {
    MFMailComposeViewController.canSendMail()
      ? presentViewController(mailController, animated: true, completion: nil)
      : presentAlert(Text.Contact.title, message: Text.Contact.message)
  }

  func presentAlert(title: String, message: String, button: String = Text.Contact.Error.button) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: title, style: .Default, handler: nil)
    alertController.addAction(action)
    
    presentViewController(alertController, animated: true, completion: nil)
  }
}

extension MainController: MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {

  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
}

extension MainController: WelcomeControllerDelegate {

  func presentEngineController() {
    changeRootView(engineController)
  }
}

extension MainController: EngineControllerDelegate {

  func enginePresentMenu() {
    menuController.kind = .Default
    presentMenu()
  }
}

extension MainController: StoryControllerDelegate {

  func storyMenuDidPress() {
    menuController.kind = storyController.kind == .Story ? .Story : .Motivation
    presentMenu()
  }
}

extension MainController: MenuControllerDelegate {

  func menuShouldPresentController(controller: MenuController.Controllers) {
    switch(controller) {
    case .Story:
      storyController.kind = .Story
      changeRootView(storyController)
    case .Interactive:
      changeRootView(engineController)
    case .Motivation:
      storyController.kind = .Motivation
      changeRootView(storyController)
    case .End:
      changeRootView(finaleController)
    case .Github:
      presentGithub()
    case .Contact:
      presentContact()
    }
  }
}
