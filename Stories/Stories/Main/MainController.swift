import UIKit

class MainController: GeneralController {

  lazy var welcomeController: WelcomeController = { [unowned self] in
    let controller = WelcomeController()
    controller.delegate = self

    return controller
  }()

  lazy var engineController: EngineController = {
    let controller = EngineController()
    return controller
  }()

  lazy var menuController: MenuController = {
    let controller = MenuController()
    return controller
  }()

  lazy var storyController: StoryController = {
    let controller = StoryController()
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(welcomeController.view)
    welcomeController.view.frame = UIScreen.mainScreen().bounds
  }

  // MARK: - Animation

  func animate() {
    welcomeController.animate()
  }
}

extension MainController: WelcomeControllerDelegate {

  func presentEngineController() {
    engineController.view.alpha = 0
    engineController.animate()
  }
}
