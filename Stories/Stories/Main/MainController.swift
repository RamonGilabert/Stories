import UIKit

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

  lazy var storyController: StoryController = {
    let controller = StoryController()
    controller.view.frame = UIScreen.mainScreen().bounds

    return controller
  }()

  var controllers = []

  override func viewDidLoad() {
    super.viewDidLoad()

    controllers = [welcomeController, engineController, storyController]
    view.addSubview(welcomeController.view)
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

    controller.animate()
  }

  func presentMenu() {
    menuController.modalPresentationStyle = .Custom
    menuController.transitioningDelegate = menuController.transition

    presentViewController(menuController, animated: true, completion: nil)
  }
}

extension MainController: WelcomeControllerDelegate {

  func presentEngineController() {
    changeRootView(engineController)
  }
}

extension MainController: EngineControllerDelegate {

  func enginePresentMenu() {
    presentMenu()
  }
}

extension MainController: MenuControllerDelegate {

  func menuShouldPresentController(controller: MenuController.Controllers) {
    switch(controller) {
    case .Story:
      break
    case .Interactive:
      break
    case .Motivation:
      break
    case .End:
      break
    case .Github:
      break
    case .Contact:
      break
    }
  }
}
