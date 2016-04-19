import UIKit

class WelcomeController: GeneralController {

  lazy var welcomeView: WelcomeView = {
    let view = WelcomeView()
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
