import UIKit

class MainController: GeneralController {

  lazy var welcomeController: WelcomeController = {
    let controller = WelcomeController()
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
